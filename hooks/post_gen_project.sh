#!/bin/bash

set -e

echo "Making sure smoke test passes and we can build a distribution tarball ..."

set -x
./gradlew clean test distTar

if ! ./gradlew jmh; then
    set +x
    echo "WARNING: ./gradlew jmh seems to be broken" >&2
else
    set +x
    echo "Everything looks good."
fi

if [[ "{{cookiecutter.use_git}}" == "True" ]]; then
    set +x
    echo "Initializing git repo"

    set -x
    if [[ -z "$GIT" ]]; then
        GIT="$(which git)"
    fi

    if [[ ! -z "$GIT" && -x "$GIT" ]]; then
        "$GIT" init
        "$GIT" add .
        "$GIT" commit -a -m "Initial import"
    else
        echo "WARNING: git requested, but git binary not found" >&2
    fi
fi

