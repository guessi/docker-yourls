#!/bin/sh

docker build -t guessi/docker-yourls:1.9.1               -f ./dockerfiles/Dockerfile .
docker build -t guessi/docker-yourls:1.9.1-theme         -f ./dockerfiles/Dockerfile.theme .
docker build -t guessi/docker-yourls:1.9.1-noadmin       -f ./dockerfiles/Dockerfile.noadmin .
