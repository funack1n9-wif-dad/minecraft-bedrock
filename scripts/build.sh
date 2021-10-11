#!/bin/bash


PROJECT_ROOT=${1:-.}

docker build -t wilder/minecraft-bedrock:1.17.34.02 $PROJECT_ROOT
