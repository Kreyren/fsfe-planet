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
	&& ${APT_GET:-"apt-get"} autoremove -qy \
	&& ${RM:-"rm"} -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Get hadolint
RUN ${CURL:-"curl"} -so "$HADOLINT" https://github.com/hadolint/hadolint/releases/download/v$HADOLINT_VERSION/hadolint-Linux-x86_64

# Get cargo-make
RUN true \
	cargo install cargo-make

USER gitpod