#!/usr/bin/env bash

source ./helpers/check-root-privileges.sh

check_root_privileges

# Setup disk layout and filesystems
chmod +x ./run-disko.sh && ./run-disko.sh

# Clone SSH from vault repository and move it to /root/.ssh
chmod +x ./clone-ssh.sh && ./clone-ssh.sh

# Clone SOPS keys and move the decrypted version to newly created sops directory under /persist
chmod +x ./clone-sops.sh && ./clone-sops.sh

# Run installation command for desired host
chmod +x ./run-install.sh && ./run-install.sh