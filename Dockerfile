FROM httpd:2.4

ENV DEBIAN_FRONTEND=noninteractive LANG=en_US.UTF-8 LC_ALL=C.UTF-8 LANGUAGE=en_US.UTF-8

# Set apt sources and preferences
RUN mv /etc/apt/sources.list /etc/apt/sources.list.d/stable.list
RUN sed "s/stretch/testing/g" /etc/apt/sources.list.d/stable.list > /etc/apt/sources.list.d/testing.list
COPY preferences.d/* /etc/apt/preferences.d/

# update and install packages
RUN [ "apt-get", "-q", "update" ]
RUN [ "apt-get", "-qy", "--allow-downgrades", "--allow-remove-essential", "--allow-change-held-packages", "upgrade" ]
RUN apt-get install -y planet-venus/testing
RUN apt-get install -y procps cron
RUN [ "apt-get", "clean" ]
RUN [ "rm", "-rf", "/var/lib/apt/lists/*", "/tmp/*", "/var/tmp/*" ]

# Add venus user
RUN adduser --quiet --disabled-password --shell /bin/bash --home /home/venus --gecos "User" venus

# Enable cron
ADD cron.txt /etc/cron.d/planet
RUN chmod 0644 /etc/cron.d/planet

# Clean default Apache sites 
RUN rm -rf /usr/local/apache2/htdocs/*

# Copy Apache config
COPY httpd.conf /usr/local/apache2/conf/httpd.conf

# Copy directories
COPY faces /usr/local/apache2/htdocs/faces
COPY images /usr/local/apache2/htdocs/images
COPY design /usr/local/apache2/htdocs/design
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

# Ugly hack to break caching from here on
ADD https://status.fsfe.org/fsfe.org/ /dev/null

# Initially run all planets
RUN planet /home/venus/lang/da/planet_da.ini
RUN planet /home/venus/lang/de/planet_de.ini
RUN planet /home/venus/lang/en/planet_en.ini
RUN planet /home/venus/lang/eo/planet_eo.ini
RUN planet /home/venus/lang/es/planet_es.ini
RUN planet /home/venus/lang/fi/planet_fi.ini
RUN planet /home/venus/lang/fr/planet_fr.ini
RUN planet /home/venus/lang/gmq/planet_gmq.ini
RUN planet /home/venus/lang/it/planet_it.ini
RUN planet /home/venus/lang/nl/planet_nl.ini
RUN planet /home/venus/lang/no/planet_no.ini
RUN planet /home/venus/lang/sk/planet_sk.ini
RUN planet /home/venus/lang/sl/planet_sl.ini
RUN planet /home/venus/lang/sv/planet_sv.ini

# Switch back to root and run cron+Apache
USER root
CMD httpd -DFOREGROUND & cron && : >> /home/venus/planet.log && tail -f /home/venus/planet.log
