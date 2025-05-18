#!/usr/bin/env bash

git clone https://github.com/Aquastias/Nixos-Secrets.git --depth=1 secrets
nix-shell -p age --run "age -d -o ./secrets/keys.txt ./secrets/keys.txt.age"
mkdir -p /mnt/persist/sops-nix/age
cp ./secrets/keys.txt /mnt/persist/sops-nix/age
chmod 0400 /mnt/persist/sops-nix/age/keys.txt