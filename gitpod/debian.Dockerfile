FROM debian:stable

USER root

ENV \
	# Prevent bricked workspaces (https://github.com/gitpod-io/gitpod/issues/1171)
	DEBIAN_FRONTEND="noninteractive" \
	LANG="en_US.UTF-8" \
	LC_ALL="C" \
	HADOLINT_VERSION="${HADOLINT_VERSION:-"1.19.0"}" \
	HADOLINT="/usr/bin/hadolint"

# Get dependencies
RUN true \
	&& ${APT_GET:-"apt-get"} update \
	&& ${APT_GET:-"apt-get"} install -qy \
		curl \
		docker.io \
		docker-compose \
		cargo \
    # HACK(Krey): Part of hack to get privileged access in workspaces
		sudo \
	&& ${APT_GET:-"apt-get"} autoremove -qy \
	&& ${RM:-"rm"} -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# HACK(Krey): This is a hack for preview feature to get privileged access in the gitpod <Unable to file bug - banned>
RUN true \
	&& ${USERADD:-"useradd"} \
		# See https://docs.docker.com/develop/develop-images/dockerfile_best-practices/#user
		--no-log-init \
		--uid "${GITPOD_USER_ID:-"33333"}" \
		--groups sudo \
		--create-home --home-dir "/home/gitpod" \
		--shell "${GITPOD_USER_SHELL:-"/bin/bash"}" \
		--password "${GITPOD_USER_PASS:-"gitpod"}" \
	&& ${SED:-"sed"} -i.bkp -e 's/%sudo\s\+ALL=(ALL\(:ALL\)\?)\s\+ALL/%sudo ALL=NOPASSWD:ALL/g' /etc/sudoers

# Get hadolint
RUN ${CURL:-"curl"} -so "$HADOLINT" https://github.com/hadolint/hadolint/releases/download/v$HADOLINT_VERSION/hadolint-Linux-x86_64

# Get cargo-make
RUN true \
	cargo install cargo-make

USER gitpod
