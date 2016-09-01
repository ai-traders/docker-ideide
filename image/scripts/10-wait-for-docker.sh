#!/bin/bash

wait_for_docker() {
    # wait up to 15 seconds for the docker socket to exist.  see
    # https://github.com/dotcloud/docker/issues/5359
    # https://github.com/chef-cookbooks/docker/blob/v1.0.37/templates/default/sysvinit/docker.erb
    # "service docker start returns before the pidfile exists"
    # docker-ssdpid does not exist on ubuntu
    tries=0
    while [ ! -e "/var/run/docker.pid" ] || [ ! -e "/var/run/docker.sock" ]; do
      sleep 1
      tries=$(($tries + 1))
      if [ $tries -gt 15 ]; then
          echo "break after: ${tries} seconds"
          break;
      fi
      echo "docker socket does not exist after: ${tries} seconds"
    done
}

service docker start
wait_for_docker
