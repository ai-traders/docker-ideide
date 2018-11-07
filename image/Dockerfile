FROM debian:9.5-slim

# For ide:
# * entrypoint requires sudo
# * git is needed to install ide image configs
# * ca-certificates is needed to use https://github.com
RUN export DEBIAN_FRONTEND=noninteractive &&\
  apt-get update && apt-get install -y --yes --no-install-recommends bash sudo git ca-certificates &&\
  git clone --depth 1 -b 0.10.4 https://github.com/ai-traders/ide.git /tmp/ide_git &&\
  /tmp/ide_git/ide_image_scripts/src/install.sh &&\
  rm -r /tmp/ide_git &&\
  echo 'ide ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

COPY etc_ide.d/scripts/* /etc/ide.d/scripts/
COPY etc_ide.d/variables/* /etc/ide.d/variables/

ENTRYPOINT ["/usr/bin/entrypoint.sh"]
CMD ["/bin/bash"]

# Install all at once to avoid many apt-get update
# * make is needed to install Shpec
RUN apt-get update &&\
  apt-get install -y --yes --no-install-recommends apt-transport-https curl gnupg2 wget &&\
  echo "deb https://download.docker.com/linux/debian stretch stable" > /etc/apt/sources.list.d/docker.list &&\
  curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - &&\
  apt-get update && apt-get install -y --yes --no-install-recommends docker-ce=18.06.1~ce~3-0~debian make nano &&\
  sh -c "`curl -L https://raw.github.com/rylnd/shpec/0.2.2/install.sh`" &&\
  curl -L https://github.com/docker/compose/releases/download/1.23.1/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose &&\
  chmod +x /usr/local/bin/docker-compose &&\
  usermod -aG docker ide &&\
  rm -Rf /var/lib/docker/* &&\
  apt-get -y autoremove &&\
  apt-get -y autoclean &&\
  apt-get -y clean &&\
  rm -rf /tmp/* /var/tmp/* &&\
  rm -rf /var/lib/apt/lists/*
COPY etc_default_docker /etc/default/docker
VOLUME /var/lib/docker

# Install bats
RUN git clone --depth 1 https://github.com/sstephenson/bats.git /opt/bats &&\
  git clone --depth 1 https://github.com/ztombol/bats-support.git /opt/bats-support &&\
  git clone --depth 1 https://github.com/ztombol/bats-assert.git /opt/bats-assert &&\
/opt/bats/install.sh /usr/local
