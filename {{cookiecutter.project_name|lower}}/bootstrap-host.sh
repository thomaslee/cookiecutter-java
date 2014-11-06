#!/bin/bash

set -ex

JAVA_VERSION=8u25

bootstrap_primary() {
    install_default_jdk

    mkdir -p "/opt/$PROJECT_NAME/builds"
    # mkdir -p "/opt/$PROJECT_NAME/shared/bin"
    mkdir -p "/opt/$PROJECT_NAME/shared/log"
    mkdir -p "/opt/$PROJECT_NAME/shared/data"
    mkdir -p "/opt/$PROJECT_NAME/shared/tmp"
    chown -R "$SSH_USER:$SSH_GROUP" "/opt/$PROJECT_NAME"
    # symlink target is created by deploy
    ln -s "/opt/$PROJECT_NAME/current/init.sh" "/etc/init.d/$PROJECT_NAME"
}

install_default_jdk() {
    install_oracle_jdk "$JAVA_VERSION" "$DATADIR/jdk-$JAVA_VERSION-linux-x64.tar.gz"
}

install_oracle_jdk() {
    local version="$1"
    local tarball="$2"
    [ -d /opt/jdk ] || mkdir -p /opt/jdk
    cd /opt/jdk
    if [ ! -d 8u25 ]; then
        tar xvfz "$tarball"
        local major_version="$(echo "$version" | sed -e 's/u.*//')"
        local release_version="$(echo "$version" | sed -e 's/.u//')"
        mv "jdk1.${major_version}.0_${release_version}" "$version"
    fi
    [ ! -h current ] || rm -f current
    ln -s "$version" current
    [ ! -f /etc/profile.d/jdk.sh ] || rm -f /etc/profile.d/jdk.sh
    echo 'export JAVA_HOME="/opt/jdk/current"' >/etc/profile.d/jdk.sh
    echo 'export PATH="$JAVA_HOME/bin:$PATH"' >>/etc/profile.d/jdk.sh
}

main() {
    local node_id="$1"
    bootstrap_${node_id}
}

PROJECT_NAME="{{cookiecutter.project_name|lower}}"
if [ -z "$SSH_USER" ]; then
    SSH_USER=vagrant
fi
if [ -z "$SSH_GROUP" ]; then
    SSH_GROUP="$SSH_USER"
fi

if [ -z "$DATADIR" ]; then
    DATADIR="/mnt/bootstrap"
fi

main "$@"

