# Epic Cash Release - Packer component

This component helps to build new windows boxes to be used on the releases.

The following is required to build using packer:
- [Packer](https://developer.hashicorp.com/packer/tutorials/docker-get-started/get-started-install-cli)
- [Virtualbox](https://www.virtualbox.org/wiki/Linux_Downloads)
- [Vagrant](https://developer.hashicorp.com/vagrant/downloads)

## How it works

Packer is used to build boxes that can be used as VM machines. To build the boxes, Packer provision the machine and run bash and PowerShell commands to prepare the machine before it gets turned into a box.

To provision the machine with the requirements to build the Epic Cash releases on windows, packer uses chocolatey to install the following components:

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

The output box can then be used with Vagrant to build VMs.

## How to build a new box

The process to build a new box is easy, but it is resource intensive and can take more than 2 hours to finish.

The following command can be used to build a new box:

```bash
packer build windows_10.json
```

After the execution is complete, a new `.box` will be outputted.

The following can be executed to add it as a valid Vagrant box:

```bash
vagrant box add --name windows-epic-cash ./windows_10.box
```

Or the same image can be turned public on: https://app.vagrantup.com/

# References

The base project used to build this approach can be found on:
- https://github.com/StefanScherer/packer-windows

More information about the windows packer machines can be found on:
- https://github.com/jeffskinnerbox/Windows-10-Vagrant-Box
