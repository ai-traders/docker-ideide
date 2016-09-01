#!/bin/bash

. ./image/scripts/variables.sh
if [[ $(git tag | grep "${this_image_tag}" -c) -ne 0 ]]; then
	echo "git tag: ${this_image_tag} exists already, please bump version in "\
	"scripts/variables.sh"
	exit 1
fi
cd image && docker build -t ${this_image_name}:${this_image_tag} --rm .
