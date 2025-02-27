#!/usr/bin/env bash

if ! command -v nix-instantiate &>/dev/null; then
  echo "nix-instantiate could not be found. Please install nix-instantiate."
  exit 127
fi

if ! command -v sed &>/dev/null; then
  echo "sed could not be found. Please install sed."
  exit 127
fi

users_nix_file="../users.nix"

if ! users_json=$(nix-instantiate --eval --strict --json "$users_nix_file"); then
  echo "Error evaluating users.nix"
  exit 1
fi

users_array=$(echo "$users_json" | sed 's/\[//;s/\]//;s/"//g;s/,/\\n/g')

if [[ -z "$users_array" ]]; then
  echo "Error parsing JSON (likely empty array)"
  exit 1
fi

readarray -t users <<< "$users_array"

if ! mkdir -p /mnt/persist/home; then
  echo "Failed to create directory /mnt/persist/home"
  exit 1
fi

for user in "${users[@]}"; do
  if ! mkdir -p "/mnt/persist/home/$user"; then
    echo "Failed to create directory /mnt/persist/home/$user"
    exit 1
  fi

  echo "Created directory /mnt/persist/home/$user"
done