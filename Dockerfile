FROM debian:8.2
MAINTAINER Ewa Czechowska <ewa@ai-traders.com>

COPY scripts/* /usr/bin/

# entrypoint requires sudo and it should be first installed, then set
# also we need: git, docker, shellcheck and shpec
# we need make to install shpec

RUN apt-get update && apt-get install -y ca-certificates wget &&\
    echo "deb http://archive.ubuntu.com/ubuntu/ trusty-backports restricted main universe" > \
    /etc/apt/sources.list.d/shellcheck.list &&\
    echo "deb http://apt.ai-traders.com/docker debian-jessie main" > \
    /etc/apt/sources.list.d/docker.list &&\
    wget http://apt.ai-traders.com/pubkey.gpg -O - | apt-key add - &&\
    apt-get update && apt-get install -y git sudo shellcheck rake curl docker-engine make &&\
    apt-get -y autoremove &&\
    apt-get -y autoclean &&\
    apt-get -y clean &&\
    rm -rf /tmp/* /var/tmp/* &&\
    rm -rf /var/lib/apt/lists/* &&\
    sh -c "`curl -L https://raw.github.com/rylnd/shpec/master/install.sh`" &&\
    echo "DOCKER_OPTS=\"--graph=/var/lib/docker -H unix:///var/run/docker.sock -H tcp://0.0.0.0:2375 --insecure-registry=docker-registry.ai-traders.com --mtu=1500 --storage-driver=overlay\"" > /etc/default/docker

RUN useradd -d /home/ide -p pass -s /bin/bash -u 1000 -m ide &&\
    chmod 755 /usr/bin/ide-fix-uid-gid.sh &&\
    chmod 755 /usr/bin/ide-setup-identity.sh &&\
    chmod 755 /usr/bin/entrypoint.sh &&\
    echo 'ide ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers &&\
    chown ide:ide -R /home/ide &&\
    usermod -aG docker ide

# add image metadata
RUN touch /etc/docker_metadata.txt && \
    VERSION=$(cat /usr/bin/docker_image_version.txt) && \
    echo "base_image_name=\"debian\"\n\
base_image_tag=\"8.2\"\n\
this_image_name=\"ideide\"\n\
this_image_tag=\"${VERSION}\"\n\
" >> /etc/docker_metadata.txt

ENTRYPOINT ["/usr/bin/entrypoint.sh"]
CMD ["/bin/bash"]
