#!/bin/sh

docker push guessi/docker-yourls:1.8.2
docker push guessi/docker-yourls:1.8.2-theme
docker push guessi/docker-yourls:1.8.2-noadmin

docker tag guessi/docker-yourls:1.8.2 guessi/docker-yourls:latest

docker push guessi/docker-yourls
