#!/bin/bash

###########################################################################
# This file ensures files are mapped from ide_identity into ide_home.
# Fails if any required secret or configuration file is missing.
###########################################################################

source /etc/ide.d/variables.sh

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
