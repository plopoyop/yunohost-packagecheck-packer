#!/usr/bin/env bash
echo "deb http://deb.debian.org/debian bookworm-backports main" | sudo tee -a /etc/apt/sources.list.d/backport.list

sudo apt update

sudo apt install -y \
    lynx \
    jq \
    git \
    btrfs-progs \
    python3-pip \
    python3-jsonschema \
    python3-toml \
    incus/bookworm-backports

sudo usermod -a -G incus-admin yunohost
