#!/bin/bash

PROJECT_ROOT=${1:-.}

docker build -t wilder/dev-minecraft-bedrock:1.16.220.01 -f$PROJECT_ROOT/dev.Dockerfile $PROJECT_ROOT