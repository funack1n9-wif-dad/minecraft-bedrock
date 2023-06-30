#!/bin/bash

1.20.1.02="${1:-1.20.1.02}"

docker build --build-arg="CORE_VERSION=${1.20.1.02}" -t "wilder/minecraft-bedrock:${1.20.1.02}" .

# Update scripts and other files
