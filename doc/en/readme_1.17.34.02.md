[english doc]: https://github.com/LomotHo/minecraft-bedrock
[older version]: https://github.com/LomotHo/minecraft-bedrock/tree/master/doc/en
[docker pulls]: https://img.shields.io/docker/pulls/lomot/minecraft-bedrock?style=flat-square
[how to install docker]: https://docs.docker.com/install/linux/docker-ce/ubuntu/
[minecraft server]: https://minecraft.net/en-us/download/server/bedrock/

[English doc] | [Older version]

![Docker Pulls]

# A bedrock Minecraft PE Server on Docker

This documentation is for image lomot/minecraft-bedrock:1.17.34.02

## Start the server

#### 1. Install Docker in your server

```bash
apt install docker.io
```

or you can follow this documentation : [How to install Docker]

#### 2. Create a folder for server data

This folder is for your world data and some configuration files, it contains `permissions.json`,`server.properties`,`whitelist.json`,`worlds`, if you use an empty folder, all the files will be created automatically, for example `/opt/mcpe-data`

```bash
mkdir -p /opt/mcpe-data
```

#### 3. Deploy the server

```bash
docker run -itd --restart=always --name=mcpe --net=host \
  -v /opt/mcpe-data:/data \
  lomot/minecraft-bedrock:1.17.34.02
```

## Upgrade the server

#### 1. Backup your data

Backup the folder `/opt/mcpe-data`

```bash
cp -r /opt/mcpe-data /opt/mcpe-data.bak
```

#### 2. Exit and delete the old container

```bash
docker container stop mcpe
docker container rm mcpe
```

#### 3. Start a new container

```bash
docker run -itd --restart=always --name=mcpe --net=host \
  -v /opt/mcpe-data:/data \
  lomot/minecraft-bedrock:1.17.34.02
```

## Manage the server

### Enter or quit the game console

```bash
docker attach mcpe
```

To quit, press `ctrl + p + q`

Use `ctrl + c` or `ctrl + d`to kill the process

### Use this command to stop/start/restart/rm the server

```bash
docker container stop/start/restart/rm mcpe
```

### Change the server port

To change the server port, update `server-port` in the file`server.properties`

Using bridge networks will decrease the network performance, it is supposed to use host networks.

### About addons, behavior_packs and resource_packs

There are too many files about addons to configure, so I made another image, to use this image, you need to manage server folder by yourself, such as update and configuration files, you can download the server files here [Minecraft server].

How to use:

```bash
docker run -itd --restart=always --name=mcpe --net=host \
  -v /opt/mcpe-data:/mcpe \
  lomot/minecraft-bedrock:base
```

## Binary file from

https://minecraft.net/en-us/download/server/bedrock/

## Docker Hub

https://hub.docker.com/r/lomot/minecraft-bedrock

## Github

https://github.com/LomotHo/minecraft-bedrock