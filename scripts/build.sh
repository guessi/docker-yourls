#!/bin/sh

docker build -t guessi/docker-yourls:1.8.2               -f ./dockerfiles/Dockerfile .
docker build -t guessi/docker-yourls:1.8.2-theme         -f ./dockerfiles/Dockerfile.theme .
docker build -t guessi/docker-yourls:1.8.2-noadmin       -f ./dockerfiles/Dockerfile.noadmin .
