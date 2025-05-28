#!/usr/bin/env bash

check_root_privileges() {
  if [[ $EUID -ne 0 ]]; then
    echo "ERROR: This script or function must be run as root (or with sudo)." >&2
    exit 1
  fi
}