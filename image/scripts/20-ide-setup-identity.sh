#!/bin/bash

###########################################################################
# This file ensures files are mapped from ide_identity into ide_home.
# Fails if any required secret or configuration file is missing.
###########################################################################

# This is the directory we expect to be mounted as docker volume.
# From that directory we mapt configuration and secrets files.
ide_identity="/ide/identity"
ide_home="/home/ide"
ide_work="/ide/work"

# obligatory file; in order to ensure that after bash login, the ide user
# is in /ide/work. Not obligatory but shortens end user's commands.
# Do not copy it from $IDE_IDENTITY, because it may reference sth not installed in
# this docker image.
touch "${ide_home}/.profile"
echo "cd ${ide_work}" > "${ide_home}/.profile"

# not obligatory configuration file
if [ -f "${ide_identity}/.gemrc" ]; then
  cp "${ide_identity}/.gemrc" "${ide_home}"
fi

# not obligatory configuration file
if [ -f "${ide_identity}/.gitconfig" ]; then
  cp "${ide_identity}/.gitconfig" "${ide_home}"
fi

# Absolute path to this script
script_path=$(readlink -f "$BASH_SOURCE")
# Absolute path to a directory this script is in
script_dir=$(dirname "${script_path}")
source ${script_dir}/variables.sh
