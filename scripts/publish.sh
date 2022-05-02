#!/bin/sh

docker push guessi/docker-yourls:1.9.0
docker push guessi/docker-yourls:1.9.0-theme
docker push guessi/docker-yourls:1.9.0-noadmin

docker tag guessi/docker-yourls:1.9.0 guessi/docker-yourls:latest

docker push guessi/docker-yourls
