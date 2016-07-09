#!/bin/bash

set -e

echo "Making sure smoke test passes and we can build a distribution tarball ..."

set -x
./gradlew clean test distTar

set +x
echo "Everything looks good."

if [[ "{{cookiecutter.use_git}}" == "True" ]]; then
    git init
    git add .
    git commit -a -m "Initial import"
fi

