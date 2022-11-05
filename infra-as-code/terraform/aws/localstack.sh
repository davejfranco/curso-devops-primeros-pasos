#!/bin/bash

start() {
    docker run -d \
        --name localstack \
        --rm \
        -it \
        -p 4566:4566 \
        -p 4510-4559:4510-4559 \
        localstack/localstack
}

stop() {
    docker stop localstack
}

case $1 in 
    "start") start 
    ;;
    "stop") stop 
    ;;
    *) echo "Unrecognized action"
    ;;
esac
