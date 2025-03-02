#!/usr/bin/env bash

if [[ $EUID -ne 0 ]]; then
  echo "This script must be run as root (sudo)."
  exit 1
fi

chmod +x ./run-disko.sh && ./run-disko.sh
chmod +x ./create-home-for-users.sh && ./create-home-for-users.sh

rm -rf /mnt/persist/nixos
git clone https://github.com/Aquastias/Nixos-Dotfiles.git /mnt/persist/nixos
nixos-install --root /mnt --flake /mnt/persist/nixos#vanguard