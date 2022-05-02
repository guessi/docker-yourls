#!/bin/sh

docker build -t guessi/docker-yourls:1.9.0               -f ./dockerfiles/Dockerfile .
docker build -t guessi/docker-yourls:1.9.0-theme         -f ./dockerfiles/Dockerfile.theme .
docker build -t guessi/docker-yourls:1.9.0-noadmin       -f ./dockerfiles/Dockerfile.noadmin .
