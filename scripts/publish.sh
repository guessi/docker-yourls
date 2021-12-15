#!/bin/sh

docker push guessi/docker-yourls:1.8.1
docker push guessi/docker-yourls:1.8.1-theme
docker push guessi/docker-yourls:1.8.1-noadmin

docker tag guessi/docker-yourls:1.8.1 guessi/docker-yourls:latest

docker push guessi/docker-yourls
