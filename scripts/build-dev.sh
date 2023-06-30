#!/bin/bash

PROJECT_ROOT=${1:-.}

docker build -t wilder/dev-minecraft-bedrock:$MC_BR_VERSION -f$PROJECT_ROOT/dev.Dockerfile $PROJECT_ROOT