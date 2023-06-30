#!/bin/bash


PROJECT_ROOT=${1:-.}

docker build -t wilder/minecraft-bedrock:1.20.1.02 $PROJECT_ROOT
