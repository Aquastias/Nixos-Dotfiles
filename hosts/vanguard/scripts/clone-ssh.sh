#!/usr/bin/env bash

git clone https://github.com/Aquastias/Vault.git --depth=1 vault
nix-shell -p age --run "age -d -o ./vault/Git-SSH.tar.gz.enc ./vault/Git-SSH.tar.gz.enc.age"
nix-shell -p openssl --run "openssl enc -aes-256-cbc -d -pbkdf2 -iter 100000 -salt -in ./vault/Git-SSH.tar.gz.enc | tar xzf - -C /root/.ssh"