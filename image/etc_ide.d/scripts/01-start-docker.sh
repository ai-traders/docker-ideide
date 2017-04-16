#!/bin/bash

source /etc/default/docker
sudo touch /var/log/docker.log
sudo chmod 777 /var/log/docker.log
sudo /usr/bin/dockerd ${DOCKER_OPTS} >/var/log/docker.log 2>/var/log/docker.log &
