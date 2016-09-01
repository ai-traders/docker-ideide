#!/bin/bash -e

source image/scripts/variables.sh
cd test
echo "---------------------------"
ide rake shellcheck
echo "---------------------------"
ide shpec --version
echo "---------------------------"
# this gem installs native extensions, so may exit 1
ide gem install gherkin
echo "---------------------------"
ide sudo service docker status
echo "---------------------------"
