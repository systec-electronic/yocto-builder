# Dockerfile for Yocto build

## System Requirements

* git
* docker

## Archives

There are two archives delivered as part of the BSP development kit:

* `yocto-builder-<version>-<git hash>.tar.gz`:
  This archive contains a Docker setup which can be used to build Yocto images
  and the Yocto SDK.
* `yocto-<version>-<git hash>.tar.gz`:
  This archive contains a full Yocto project setup as a baseline to start
  development for the ECUcore-AM62x.

Both files contain bare git-repositories.

## Setup project structure

Extract all tarballs and use the following commands to get a working Yocto
setup.

```sh
git clone <PATH_TO_DOWNLOADS>/yocto-builder.git
cd yocto-builder/shared
git clone <PATH_TO_DOWNLOADS>/yocto.git --recurse-submodules
cd ../..
docker compose build yocto-builder
docker compose run --rm yocto-builder

# from here on one can follow the instructions described in yocto/README.md
#
# For example to build the default image run the following commands:
cd shared/yocto/build
. conf/setenv
bitbake sysworxx-image-default
```
