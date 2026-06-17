#!/bin/bash
export DOWNLOAD_DIR=$HOME/greenbone-community-container && mkdir -p $DOWNLOAD_DIR
cd $DOWNLOAD_DIR
curl -f -O -L https://greenbone.github.io/docs/latest/_static/compose.yaml -o docker-compose.yml
docker compose -f $DOWNLOAD_DIR/docker-compose.yml -p greenbone-community-edition pull
docker compose -f $DOWNLOAD_DIR/docker-compose.yml -p greenbone-community-edition up -d
