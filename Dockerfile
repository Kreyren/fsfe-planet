FROM httpd:2.4 as planet

ENV \
    DEBIAN_FRONTEND="noninteractive" \
    LANG="en_US.UTF-8" \
    LC_ALL="C.UTF-8" \
    LANGUAGE="en_US.UTF-8"

# update and install packages
RUN true \
    && apt-get -q update \
    && apt-get upgrade \
        --quiet \
        --yes \
        --allow-downgrades \
        --allow-remove-essential \
        --allow-change-held-packages \
    && apt-get install --yes \
        planet-venus \
        procps \
        cron \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Add venus user
RUN adduser --quiet --disabled-password --shell /bin/bash --home /home/venus --gecos "User" venus

# Enable cron
COPY docker/confdir/cron.d/planet /etc/cron.d/planet
RUN chmod 0644 /etc/cron.d/planet

# Clean default Apache sites 
RUN rm -rf /usr/local/apache2/htdocs/*

# Copy Apache config
COPY httpd.conf /usr/local/apache2/conf/httpd.conf

# Copy directories
COPY faces /usr/local/apache2/htdocs/faces
COPY graphics /usr/local/apache2/htdocs/graphics
COPY look /usr/local/apache2/htdocs/look
COPY fonts /usr/local/apache2/htdocs/fonts
COPY theme /home/venus/theme
COPY lang /home/venus/lang
COPY bin /home/venus/bin
RUN touch /home/venus/planet.log

# Set correct permissions
RUN chown -R venus:venus /usr/local/apache2/htdocs /home/venus/

# Switch to non-privileged user
USER venus

# Link EN as the default page
WORKDIR /usr/local/apache2/htdocs/
RUN ln -s en/atom.xml en/foafroll.xml en/index.html en/opml.xml en/rss20.xml .

# FIXME-QA(Krey): Why are we breaking caching?
# Ugly hack to break caching from here on
ADD https://status.fsfe.org/fsfe.org/ /dev/null

# Initially run all planets
RUN find /home/venus/lang/ -name "planet_*.ini" -exec planet {} \;

# Switch back to root and run cron+Apache
USER root
CMD true \
    && httpd -DFOREGROUND & cron \
    && : >> /home/venus/planet.log \
    && tail -f /home/venus/planet.log

FROM debian:stable as onion-service-provider

# Get The Onion Router (torproject)
RUN true \
    && apt-get update \
    && apt-get install --yes \
        tor \
    && apt-get autoremove -qy \
    && service tor stop \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /etc/tor

COPY docker/confdir/tor /etc/tor

RUN true \
    && useradd \
        --uid "${ONION_USER_ID:-"6781"}" \
        --user-group \
        --no-create-home \
        --shell /bin/nologin \
         "${ONION_USER:-"onionguy"}"

RUN true \
    && chown -R "${ONION_USER:-"onionguy"}:${ONION_GROUP:-"onionguy"}" /etc/tor

USER "${ONION_USER:-"onionguy"}"
CMD [ "/usr/bin/tor" ] 