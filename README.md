# Minecraft Modpack All the Mods 6 Docker Image

[![Build and Publish](https://github.com/curseforge-docker/all-the-mods-6/actions/workflows/build-and-publish.yml/badge.svg)](https://github.com/curseforge-docker/all-the-mods-6/actions/workflows/build-and-publish.yml)
  
This repository contains ready-to-use docker images for some of the most popular Minecraft Modpacks, such as _All the Mods 6_, _RLCraft_ and _SkyFactory 4_.

## Usage

To simply use the latest version of this modpack run
```console
docker run -d --name minecraft-server -p 25565:25565 -e EULA=true curseforge/all-the-mods-6
```
> _It is important to always add `-e EULA=true` id the docker commands as Mojang/Microsoft requires EULA acceptance._

If you want others to join you or this image runs on a server, you need to open the port 25565 (TCP) on your firewall.

To know more regarding the usage of docker, head over to the [Docker CLI reference](https://docs.docker.com/engine/reference/commandline/docker/)

### Volumes

In order to persist your data (e.g. in case of a modpack update), a volume with all your minecraft data is automatically created. 

If you want to name the volume, run

```console
docker run -v minecraft-server:/minecraft ...
```

### Image hosting

All container images are hosted on Docker Hub as well as in the Github Container Registry.  
Docker Hub
```console
docker pull curseforge/all-the-mods-6
```
Github Container Registry
```console
docker pull ghcr.io/curseforge-docker/all-the-mods-6
```
## List of available versions
| Version                                                                                     | Image details
| ------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
| [1.5.4 (latest)](https://www.curseforge.com/minecraft/modpacks/all-the-mods-6/files/3235290)| [GitHub](https://github.com/orgs/curseforge-docker/packages/container/all-the-mods-6/1491997) [Docker Hub](https://hub.docker.com/layers/curseforge/all-the-mods-6/1.5.4/images/sha256-1c8d247440058d06c2144ca7115512048715208180e286f82f40a9fb08733f0c?context=explore)

## Contribution

Please feel free to create pull requests and write about your issues here on GitHub. Constuctive Feedback is always a nice reward for our work. Though, if you are having trouble using docker or something is wrong with the modpack, please either read the docker documentation or refer to the modpack author(s).

## The credit goes to ...

... whoever works on building the modpacks!

We only make them more available for users who want to host their own servers.
