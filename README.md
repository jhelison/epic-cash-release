<h3 align="center">
Epic Cash - Releases automation
</h3>

# Table of Contents



# Description

Epic Cash is an in-progress blockchain implementation of the MimbleWimble protocol. Epic Cash redefined new core characteristics of this new privacy-focused blockchain forked from Grin

Currently, the build and creation of releases require man-hours to setup of virtual environments on different machines.

This repository has the objective of patterning the release process of the coin. Making Linux a machine to rule them all, turning the setup of release machines and requirements a breeze.

This project currently automatizes the build of releases for:
- Linux with `.deb` files
- Windows with `.exe` files

## How it works

The project has the current focus on Linux (deb) and Windows (exe) releases

### Linux

For Linux, we use Docker with frozen requirements to create the deb files.
The following libraries were applied as requirements to build the projects:
```
build-essential = 12.9ubuntu3
debhelper = 13.6ubuntu1
cmake = 3.22.1-1ubuntu1.22.04.1
libclang-dev = 1:14.0-55~exp2
libncurses5-dev = 6.3-2
clang = 1:14.0-55~exp2
libncursesw5-dev = 6.3-2
opencl-headers = 3.0~2022.01.04-1
libssl-dev = 3.0.2-0ubuntu1.7
pkg-config = 0.29.2-1ubuntu3
ocl-icd-opencl-dev = 2.2.14-3
git = 1:2.34.1-1ubuntu1.5
```

### Windows

For windows, we are using packer to build Windows box VMs with pre-installed requirements using chocolatey.
The current box used in this project is on Vagrant Cloud, https://app.vagrantup.com/Jhelison/boxes/windows-epic-cash.
The windows requirements used on the box are:
```
git.install = 2.38.1
cmake = 3.16.2
openssl = 1.1.1.1900
strawberryperl = 5.32.1.1
visualstudio2019community = 16.11.19.0
visualstudio2019-workload-nativedesktop = 1.0.1
llvm = 15.0.4
rustup.install = 1.25.1
```

## Requirements

To build the project, you must be on a Linux machine with the following requirements:
- [Virtualbox](https://www.virtualbox.org/wiki/Linux_Downloads)
- [Vagrant](https://developer.hashicorp.com/vagrant/downloads)
- [Docker](https://docs.docker.com/desktop/install/ubuntu/)

If you want to re-build the windows VM:
- [Packer](https://developer.hashicorp.com/packer/tutorials/docker-get-started/get-started-install-cli)

# Build the Epic Cash projects

## Step-by-step process

To build the Epic Cash projects you must follow these steps

1. Initialize the docker image and the vagrant box

Before getting the components to build, you must first initialize the docker image and the vagrant box using the following:

```bash
make init
```

The whole process is highly dependent on your internet connection. The Vagrant box is 15 Gb.

2. Build the deb and exe files

To get the files ready to use or to create a new release, just run the following command:

```bash
make build version=<version> repo=<repository> branch=<target-branch>
```

Where:
- version: The target version, used to name the final files
- repo: The repository to be built as an HTTPS git remote URL
- branch: Optional argument defining the branch to be cloned, defaults to master

The final output will be:
- A path with `output/<project>/<version>/` will be created, on that path will be available:
    - A zipped .deb release
    - A zipped .exe release
    - A checksum256 txt file

Example execution:
```bash
make build version=3.0.0 repo=https://github.com/EpicCash/epic.git branch=3.0.0
```
It will build the epic-server project on branch 3.0.0 with versioning 3.0.0

## Makefile commands

The following commands are available
### make init

Initialize the docker image and download the vagrant box image

### make build

Build the project and output the release files

Uses as arguments:
- version: The target version, used to name the final files
- repo: The repository to be built as an HTTPS git remote URL
- branch: Optional argument defining the branch to be cloned, defaults to master

The final output will be:
- A path with `output/<project>/<version>/` will be created, on that path will be available:
    - A zipped .deb release
    - A zipped .exe release
    - A checksum256 txt file

### make build-linux

Build only the Linux release (`.deb`)

Uses as arguments:
- version: The target version, used to name the final files
- repo: The repository to be built as an HTTPS git remote URL
- branch: Optional argument defining the branch to be cloned, defaults to master

### make build-windows

Build only the windows release (`.deb`)

Uses as arguments:
- version: The target version, used to name the final files
- repo: The repository to be built as an HTTPS git remote URL
- branch: Optional argument defining the branch to be cloned, defaults to master

### build-sha256sum

Build the checksum with SHA256 for the release files

Uses as arguments:
- version: The target version, used to name the final files
- repo: The repository to be built as an HTTPS git remote URL

# More information about the base components
- [How to build new boxes using packer](./windows/packer/README.md)
- [Acessing the Vagrant VM](./windows/vagrant/README.md)
- [Running the docker image](./linux/README.md)
