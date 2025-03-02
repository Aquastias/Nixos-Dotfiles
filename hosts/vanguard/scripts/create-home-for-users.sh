#!/usr/bin/env bash

if [[ $EUID -ne 0 ]]; then
  echo "This script must be run as root (sudo)."
  exit 1
fi

rootHome="/mnt/persist/home"

# Create the root home
rm -rf "${rootHome}" 
mkdir "${rootHome}"

# Create folders for each user
mkdir "${rootHome}/aquastias"
mkdir "${rootHome}/spark"

# Make each home accessible universally
chown -R 775 "${rootHome}/aquastias"
chown -R 775 "${rootHome}/spark"