#!/usr/bin/env bash

if [[ $EUID -ne 0 ]]; then
  echo "This script must be run as root (sudo)."
  exit 1
fi

chmod +x ./run-disko.sh && ./run-disko.sh

rm -rf /mnt/persist/nixos
git clone https://github.com/Aquastias/Nixos-Dotfiles.git --depth=1 /mnt/persist/nixos
mkdir -p /mnt/persist/sops-nix/age
cp ../../../keys.txt /mnt/persist/sops-nix/age
chmod 0400 /mnt/persist/sops-nix/age/keys.txt
nixos-install --root /mnt --flake /mnt/persist/nixos#vanguard