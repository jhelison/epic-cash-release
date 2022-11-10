# Epic Cash Release - Vagrant component

This component is the base vagrant script to run the VMs with the pre-installed requirements for the Epic Cash Windows releases.

The following is required to run the Vagrant VM:
- [Virtualbox](https://www.virtualbox.org/wiki/Linux_Downloads)
- [Vagrant](https://developer.hashicorp.com/vagrant/downloads)

## How it works

Vagrant is a tool used to build VMs based on boxes. A box is [built using packer](../packer/README.md). Currently, VMs to create Epic releases are built with these requirements:

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

## How to run a box

The following command can be used to run the windows epic cash box:

```bash
vagrant up --no-provision
```

The box will get up and can be accessed using Virtualbox.

### Getting the windows release

To get the windows release, with the vagrant machine online, copy and rename the `scripts\windows-entrypoint.bat.example` to `scripts\windows-entrypoint.bat`. And modify the following lines:

```bat
set repo=bash_repo
set branch=bash_branch
set project=bash_project
```

To represent the project you are trying to build.

Then you can just run:

```bash
vagrant provision
```

The `.exe` will be outputted to the folder.

# References

More information about the commands for Vagrant can be found on:
- https://developer.hashicorp.com/vagrant/docs
