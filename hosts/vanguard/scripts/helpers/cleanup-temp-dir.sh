#!/usr/bin/env bash

cleanup_temp_dir() {
  local dir_to_clean="$1"

  if [[ -n "$dir_to_clean" && -d "$dir_to_clean" ]]; then
    echo "INFO: Cleaning up temporary directory: $dir_to_clean"
    rm -rf "$dir_to_clean"
  elif [[ -n "$dir_to_clean" ]]; then
    echo "NOTICE: Temporary directory '$dir_to_clean' not found or was already cleaned."
  fi
}