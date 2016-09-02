#!/bin/bash -e

source ./image/etc_ide.d/variables/60-variables.sh
if [[ $(git tag | grep "${this_image_tag}" -c) -ne 0 ]]; then
	echo "git tag: ${this_image_tag} exists already, please bump version in "\
	"scripts/variables.sh"
	exit 1
fi
# on gocd there is only 1 branch fetched, fetch also master
git fetch origin master:master
git checkout master
git merge --ff-only ci
# push git code
git push origin master
git tag "${this_image_tag}"
# push git tag
git push origin "${this_image_tag}"
