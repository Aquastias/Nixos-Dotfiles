#!/usr/bin/env bash

[ -d "/mnt/persist/nixos" ] && rm -rf /mnt/persist/nixos

git clone https://github.com/Aquastias/Nixos-Dotfiles.git --depth=1 /mnt/persist/nixos

nixos-install --root /mnt --flake /mnt/persist/nixos#vanguard