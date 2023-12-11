#!/bin/sh

IMAGE_VERSION=1.9.2

CONTAINER_CMD="finch"
CONTAINER_REPO="guessi/docker-yourls"

function build() {
  ${CONTAINER_CMD} build -t ${CONTAINER_REPO}:${IMAGE_VERSION}         --target yourls  .
  ${CONTAINER_CMD} build -t ${CONTAINER_REPO}:${IMAGE_VERSION}-theme   --target theme   .
  ${CONTAINER_CMD} build -t ${CONTAINER_REPO}:${IMAGE_VERSION}-noadmin --target noadmin .
}

function publish() {
  ${CONTAINER_CMD} push ${CONTAINER_REPO}:${IMAGE_VERSION}
  ${CONTAINER_CMD} push ${CONTAINER_REPO}:${IMAGE_VERSION}-theme
  ${CONTAINER_CMD} push ${CONTAINER_REPO}:${IMAGE_VERSION}-noadmin

  ${CONTAINER_CMD} tag  ${CONTAINER_REPO}:${IMAGE_VERSION} ${CONTAINER_REPO}:latest

  ${CONTAINER_CMD} push ${CONTAINER_REPO}
}

function cleanup() {
  ${CONTAINER_CMD} compose down
  rm -rvf ./volumes/docker-entrypoint-initdb.d/*
  ${CONTAINER_CMD} volume rm yourls_mysql-data
}

$@
