#!/usr/bin/env bash

nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode destroy,format,mount ../disko-config.nix