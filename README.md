# Dockerfile for Yocto build

## System Requirements

* git
* docker

## Setup project structure

Clone the `docker` build environment and the Yocto project for sysWORXX devices.

```sh
git clone https://github.com/systec-electronic/yocto-builder.git
cd yocto-builder/shared
git clone https://github.com/systec-electronic/yocto-sysworxx.git --recurse-submodules
cd ../..
docker compose build yocto-builder
docker compose run --rm yocto-builder

# from here on one can follow the instructions described in yocto-sysworxx/README.md
#
# For example to build the default image run the following commands:
cd shared/yocto-sysworxx/build
. conf/setenv
bitbake sysworxx-image-default
```
