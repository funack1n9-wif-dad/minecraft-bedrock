#!/bin/bash

PROJECT_ROOT=${1:-.}

docker build -t wilder/dev-minecraft-bedrock:1.20.1.02 -f$PROJECT_ROOT/dev.Dockerfile $PROJECT_ROOT