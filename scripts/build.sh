#!/bin/sh

VERSION=1.9.2

docker build -t guessi/docker-yourls:${VERSION}               -f ./dockerfiles/Dockerfile .
docker build -t guessi/docker-yourls:${VERSION}-theme         -f ./dockerfiles/Dockerfile.theme .
docker build -t guessi/docker-yourls:${VERSION}-noadmin       -f ./dockerfiles/Dockerfile.noadmin .
