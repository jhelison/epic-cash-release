#!/bin/bash
source $HOME/.cargo/env

# Clone the repository
git clone $1

# Prepare cargo and build the deb
cd $(echo $1 | cut -d'/' -f5 | cut -d'.' -f1)
git submodule update --init --recursive
cargo update
./debian/rules binary

# Copy to the volume on host
cp /home/app/*.deb /home/app/output/
