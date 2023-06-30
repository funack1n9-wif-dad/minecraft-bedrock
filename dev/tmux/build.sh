#!/bin/bash

PROJECT_ROOT=${1:-.}

docker build -t wilder/tmux-minecraft-bedrock:MC_BR_VERSION -f$PROJECT_ROOT/dev/tmux/tmux.Dockerfile $PROJECT_ROOT