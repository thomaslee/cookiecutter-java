#!/bin/bash

set -ex

JAVA_PACKAGE_BASE="$(echo "{{cookiecutter.java_package_base}}" | tr . /)"
PROJECT_NAME="{{cookiecutter.project_name|lower}}"

MAINDIR="$PROJECT_NAME/src/main/java/$JAVA_PACKAGE_BASE/$PROJECT_NAME"

mkdir -p "$MAINDIR"
mv "Main.java" "$MAINDIR"
mv "ApplicationModule.java" "$MAINDIR"

git init
git config user.name "{{cookiecutter.full_name}}"
git config user.email "{{cookiecutter.email}}"
git add .
git commit -a -m "Initial import"

gradle wrapper
./gradlew idea

