#!/bin/sh

VERSION=1.9.2

docker push guessi/docker-yourls:${VERSION}
docker push guessi/docker-yourls:${VERSION}-theme
docker push guessi/docker-yourls:${VERSION}-noadmin

docker tag guessi/docker-yourls:${VERSION} guessi/docker-yourls:latest

docker push guessi/docker-yourls
