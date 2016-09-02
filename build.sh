#!/bin/bash

source ./image/etc_ide.d/variables/60-variables.sh
cd image && docker build -t ${this_image_name}:${this_image_tag} --rm .
