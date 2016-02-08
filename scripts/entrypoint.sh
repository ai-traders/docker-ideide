#!/bin/bash

###########################################################################
# This file is an init script to properly start docker container.
###########################################################################

wait_for_docker() {
    # wait up to 60 seconds for the docker socket to exist.  see
    # https://github.com/dotcloud/docker/issues/5359
    # https://github.com/chef-cookbooks/docker/blob/v1.0.37/templates/default/sysvinit/docker.erb
    # "service docker start returns before the pidfile exists"
    # docker-ssdpid does not exist on ubuntu
    tries=0
    while [ ! -e "/var/run/docker.pid" ] || [ ! -e "/var/run/docker.sock" ]; do
      sleep 1
      tries=$(($tries + 1))
      if [ $tries -gt 60 ]; then
          echo "break after: ${tries} seconds"
          break;
      fi
      echo "docker socket does not exist after: ${tries} seconds"
    done
}

set -e

/usr/bin/ide-setup-identity.sh
/usr/bin/ide-fix-uid-gid.sh

source /etc/docker_metadata.txt
GREEN='\033[0;32m'
NC='\033[0m'
if [ -t 0 ] ; then
    # interactive shell
    echo -e "${GREEN}ide init finished (interactive shell), using ${this_image_name}:${this_image_tag}${NC}"

    # No "set -e" here, you don't want to be logged out when sth returns not 0
    # in interactive shell.
    set +e
else
    # not interactive shell
    echo -e "${GREEN}ide init finished (not interactive shell), using ${this_image_name}:${this_image_tag}${NC}"
    set -e
fi

service docker start
wait_for_docker
sudo -E -H -u ide /bin/bash -lc "$@"
