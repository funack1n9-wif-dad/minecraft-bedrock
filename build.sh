#!/bin/bash

MC_BR_VERSION="${1:-1.20.1.02}"

docker build --build-arg="CORE_VERSION=${MC_BR_VERSION}" -t "wilder/minecraft-bedrock:${MC_BR_VERSION}" .

# Update scripts and other files
