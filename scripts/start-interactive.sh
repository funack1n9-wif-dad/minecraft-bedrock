#!/bin/bash
SERVER_HOME=${1:-`pwd`}

docker run -it --rm --name=mcpe --hostname=mcpe \
  -v ${SERVER_HOME}/mcpe-data:/data \
  -p 0.0.0.0:19132:19132/udp \
  wilder/minecraft-bedrock:$MC_BR_VERSION