#!/usr/bin/env bash

if ! command -v nix-instantiate &>/dev/null; then
  echo "nix-instantiate could not be found. Please install nix-instantiate."
  exit 127
fi

if ! command -v jq &>/dev/null; then
  echo "jq could not be found. Please install jq."
  exit 127
fi

users_nix_file="../users.nix"

if ! users_json=$(nix-instantiate --eval --strict --json "$users_nix_file"); then
  echo "Error evaluating users.nix"
  exit 1
fi

if ! users_array=$(echo "$users_json" | jq -r '.[]'); then
  echo "Error parsing JSON with jq"
  exit 1
fi

readarray -t users <<< "$users_array"

if ! mkdir -p /persist/home; then
  echo "Failed to create directory /persist/home"
  exit 1
fi

for user in "${users[@]}"; do
  if ! sudo mkdir -p "/persist/home/$user"; then
    echo "Failed to create directory /persist/home/$user"
    exit 1
  fi

  echo "Created directory /persist/home/$user"
done