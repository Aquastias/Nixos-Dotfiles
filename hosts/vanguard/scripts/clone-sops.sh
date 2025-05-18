#!/usr/bin/env bash

echo "Preparing SOPS keys in /persist/sops-nix/age..."

[ -d "/mnt/persist/sops-nix/age" ] || mkdir -p /mnt/persist/sops-nix/age

git clone https://github.com/Aquastias/Nixos-Secrets.git --depth=1 secrets

nix-shell -p age --run "age -d -o ./secrets/keys.txt ./secrets/keys.txt.age"
cp ./secrets/keys.txt /mnt/persist/sops-nix/age
chmod 0400 /mnt/persist/sops-nix/age/keys.txt