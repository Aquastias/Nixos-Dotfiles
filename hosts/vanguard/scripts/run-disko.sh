#!/usr/bin/env bash

echo "Preparing disk layout and filesystems..."

nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode destroy,format,mount ../disko-config.nix --yes-wipe-all-disks