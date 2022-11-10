# Epic Cash Release - Docker component

This component is the base docker with the requirements for the Epic Cash Linux releases.

The following is required to run Docker:
- [Docker](https://docs.docker.com/desktop/install/ubuntu/)

## How it works

This dockerfile was built to freeze the Linux requirements.
The docker file uses the following as dependencies:

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

## How to use it

The following steps show how to get the `.deb` release files:

1. Building the image

The docker image can be built with:

```bash
docker build . -t epic-linux-release
```

2. Running the docker image and outputting the `.deb` file

The following command can be used to run the docker image and get the `.deb` file:

```bash
docker run -v $(pwd)/ubuntu:/home/app/output epic-linux-release <repository> <branch>
```

Where:
- repo: The repository to be built as an HTTPS git remote URL
- branch: Argument defining the branch to be cloned

The `.deb` file will be outputted to the path
