#!/bin/sh

docker-compose down
rm -vf ./volumes/docker-entrypoint-initdb.d/*
docker volume rm yourls_mysql-data
