#!/bin/bash

PROJECT_ROOT=${1:-.}

docker build -t wilder/tmux-minecraft-bedrock:1.20.1.02 -f$PROJECT_ROOT/dev/tmux/tmux.Dockerfile $PROJECT_ROOT