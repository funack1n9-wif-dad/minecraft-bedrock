#!/bin/bash


PROJECT_ROOT=${1:-.}

docker build -t wilder/minecraft-bedrock:$MC_BR_VERSION $PROJECT_ROOT
