FROM ruby:2.3.1
# if you decide to not use ruby as base image, please make sure that rake
# is an invocable command
MAINTAINER Ewa Czechowska <ewa@ai-traders.com>

# * entrypoint requires sudo
# * git is needed by some ruby gems to be installed from github and
# to install ide image configs
# * make is needed to install shpec
# * keep only needed apt sources to make apt-get update faster
# * the sed line fixes https://github.com/docker/docker/pull/25869
# remove it when docker 1.12.2 is available
RUN mv /etc/apt/sources.list /root/apt-sources.list &&\
  echo "deb http://httpredir.debian.org/debian jessie main" > \
    /etc/apt/sources.list &&\
  apt-get update && apt-get install -y --force-yes --no-install-recommends apt-transport-https &&\
  echo "deb https://apt.dockerproject.org/repo/ debian-jessie main" > \
    /etc/apt/sources.list.d/docker.list &&\
  echo "deb http://archive.ubuntu.com/ubuntu/ trusty-backports restricted main universe" > \
    /etc/apt/sources.list.d/shellcheck.list &&\
  apt-get update && apt-get install -y --force-yes --no-install-recommends git sudo shellcheck curl docker-engine make nano &&\
  sh -c "`curl -L https://raw.github.com/rylnd/shpec/master/install.sh`" &&\
  sed -i 's/status_of_proc -p "$DOCKER_SSD_PIDFILE" "$DOCKER" "$DOCKER_DESC"/status_of_proc -p "$DOCKER_SSD_PIDFILE" "$DOCKERD" "$DOCKER_DESC"/g' /etc/init.d/docker &&\
  echo "DOCKER_OPTS=\"--graph=/var/lib/docker -H unix:///var/run/docker.sock -H tcp://0.0.0.0:2375\"" > /etc/default/docker &&\
  curl -L https://github.com/docker/compose/releases/download/1.8.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose &&\
  chmod +x /usr/local/bin/docker-compose &&\
  git clone --depth 1 -b configs-script http://gitlab.ai-traders.com/ide/ide.git &&\
  ide/ide_image_scripts/src/install.sh && rm -r ide &&\
  echo 'ide ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers &&\
  usermod -aG docker ide &&\
  apt-get purge make &&\
  apt-get -y autoremove &&\
  apt-get -y autoclean &&\
  apt-get -y clean &&\
  rm -rf /tmp/* /var/tmp/* &&\
  rm -rf /var/lib/apt/lists/*

COPY scripts/* /etc/ide.d/

# this (#8268) and setting overlay as docker daemon storage driver (#8419)
# is needed to build docker images inside a docker container created
# from this docker image
RUN rm -Rf /var/lib/docker/*
VOLUME /var/lib/docker

ENTRYPOINT ["/usr/bin/entrypoint.sh"]
CMD ["/bin/bash"]
