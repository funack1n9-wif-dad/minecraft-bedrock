##################  for dev  #########################
FROM alpine:latest as builder

# build config (TODO: Figure out solution to auto-config the server)
#ARG MCPE_SERVER_CONFIG="wilder-creative"
ARG CORE_VERSION

# config server
ENV SERVER_HOME="/mcpe" \
  SERVER_PATH="/mcpe/server" \
  SCRIPT_PATH="/mcpe/script" \
  DEFAULT_CONFIG_PATH="/mcpe/default-config" \
  DATA_PATH="/data" \
  IMAGE_VERSION="1"
#ENV CORE_VERSION=""

# unzip pack and download new server
RUN apk --no-cache add unzip wget \
  && mkdir -p $SERVER_PATH \
  && mkdir -p $DEFAULT_CONFIG_PATH \
  && wget -nv https://minecraft.azureedge.net/bin-linux/bedrock-server-$CORE_VERSION.zip -O /tmp/bedrock.zip

# Extract server and backup the configuration
RUN unzip -q /tmp/bedrock.zip -d $SERVER_PATH \
  && mv $SERVER_PATH/permissions.json $DEFAULT_CONFIG_PATH/ \
  && mv $SERVER_PATH/server.properties $DEFAULT_CONFIG_PATH/ \
  && mv $SERVER_PATH/allowlist.json $DEFAULT_CONFIG_PATH/ \
  && chmod +x $SERVER_PATH/bedrock_server \
  && rm /tmp/bedrock.zip


# Add custom entrypoint scripts
# COPY ./profile/mcpe/configs/$MCPE_SERVER_CONFIG $DEFAULT_CONFIG_PATH
# COPY ./profile/container/scripts $SCRIPT_PATH
COPY profile/container/scripts/docker-entrypoint.sh ${SCRIPT_PATH}/docker-entrypoint-nodev.sh
COPY profile/container/scripts/docker-entrypoint-dev.sh ${SCRIPT_PATH}/docker-entrypoint-dev.sh
COPY profile/container/scripts/docker-entrypoint-dev-mod.sh ${SCRIPT_PATH}/docker-entrypoint-dev-mod.sh
COPY profile/container/scripts/docker-entrypoint.sh ${SCRIPT_PATH}/docker-entrypoint.sh
RUN chmod +x ${SCRIPT_PATH}/*.sh


##################  for relaese  #########################
# FROM ubuntu:18.04 as production
FROM debian:10-slim as production

# install packages & config docker
# pkgs installed on 1st line of apt installs are required, 2nd line pkgs are admin tools, and 3rd line are development tools.
RUN apt-get update \
  && apt-get -y install \
    libcurl4 vim procps file htop \
    tree tcpdump sed grep gawk ack \
  && apt-get -y autoremove \
  && apt-get clean

# config server
ENV LD_LIBRARY_PATH .
ENV SERVER_HOME="/mcpe" \
  SERVER_PATH="/mcpe/server" \
  SCRIPT_PATH="/mcpe/script" \
  DEFAULT_CONFIG_PATH="/mcpe/default-config" \
  DATA_PATH="/data"
ENV SHELL="/bin/bash"

# Copy from builder stage to this stage
COPY --from=builder $SERVER_HOME $SERVER_HOME

# Add shell environment config files
COPY profile/container/.bashrc /root/.bashrc
COPY profile/container/.vimrc /root/.vimrc

# Backup orig configs and Add custom configs
RUN cp ${DEFAULT_CONFIG_PATH}/server.properties ${DEFAULT_CONFIG_PATH}/orig.server.properties \
  && cp ${DEFAULT_CONFIG_PATH}/permissions.json ${DEFAULT_CONFIG_PATH}/orig.permissions.json \
  && cp ${DEFAULT_CONFIG_PATH}/allowlist.json ${DEFAULT_CONFIG_PATH}/orig.allowlist.json
COPY profile/mcpe/configs/wilder-creative/server.properties ${DEFAULT_CONFIG_PATH}/server.properties
COPY profile/mcpe/configs/wilder-creative/permissions.json ${DEFAULT_CONFIG_PATH}/permissions.json

WORKDIR ${SERVER_PATH}
EXPOSE 19132/udp

# RUN

#ENTRYPOINT ["bash", "/mcpe/script/docker-entrypoint.sh", "/mcpe/server/bedrock_server"]  #  NOTE: Have not tried yet
ENTRYPOINT ["/mcpe/script/docker-entrypoint.sh", "/mcpe/server/bedrock_server"]
#CMD ["/mcpe/script/docker-entrypoint.sh", "/mcpe/server/bedrock_server"]



