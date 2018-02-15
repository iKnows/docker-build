#!/bin/bash


prepare(){
    [ -d ".release" ] && (
        rm -rf .release
        mkdir -p .release/tmp
    ) || (
        mkdir -p .release/tmp
    )
    git clone https://github.com/docker/docker-ce.git .release/tmp/
    mv .release/tmp/components/cli .release/
    mv .release/tmp/components/engine .release/
    rm -rf .release/tmp
}

build(){
    prepare
    action=$1
    if [ "$1" = "deb" ];then
        make deb
    elif [ "$1" = "rpm" ];then
        make rpm
    elif [ "$1" = "static" ];then
        make static
    else
        make
    fi
}

case $1 in
    deb)
        build deb
    ;;
    rpm)
        build rpm
    ;;
    static)
        build static
    ;;
    *)
    build
    ;;
esac

