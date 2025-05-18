#!/usr/bin/env bash

set -eo pipefail

readonly GIT_REPO_URL="https://github.com/Aquastias/Nixos-Dotfiles.git"
readonly FINAL_CONFIG_DIR="/mnt/persist/nixos" # Final destination for the NixOS configuration clone
readonly FLAKE_TARGET_SYSTEM_NAME="vanguard" # The #<name> part of the flake URI for nixos-install
readonly NIXOS_INSTALL_ROOT="/mnt" # --root argument for nixos-install

source ./helpers/check-root-privileges.sh
source ./helpers/cleanup-temp-dir.sh

TEMP_CLONE_DIR_PATH_FOR_CLEANUP=""

_main_script_cleanup() {
  cleanup_temp_dir "$TEMP_CLONE_DIR_PATH_FOR_CLEANUP"
}

trap _main_script_cleanup EXIT

check_root_privileges

echo "INFO: Preparing NixOS configuration for installation..."

TEMP_CLONE_DIR=$(mktemp -d)
if [[ -z "$TEMP_CLONE_DIR" || ! -d "$TEMP_CLONE_DIR" ]]; then
  echo "ERROR: Failed to create temporary directory." >&2
  exit 1 
fi

TEMP_CLONE_DIR_PATH_FOR_CLEANUP="$TEMP_CLONE_DIR"

echo "INFO: Cloning NixOS configuration from $GIT_REPO_URL into temporary directory $TEMP_CLONE_DIR..."
if ! git clone --depth=1 "$GIT_REPO_URL" "$TEMP_CLONE_DIR"; then
  echo "ERROR: Failed to clone Git repository from $GIT_REPO_URL." >&2
  exit 1
fi
echo "INFO: Git clone successful."

echo "INFO: Replacing existing configuration (if any) at ${FINAL_CONFIG_DIR} with the new clone..."

# Remove the old/existing configuration directory if it exists.
# The '--' ensures that if FINAL_CONFIG_DIR somehow starts with a '-', it's treated as a path.
if [ -d "$FINAL_CONFIG_DIR" ]; then
  echo "INFO: Removing existing directory: $FINAL_CONFIG_DIR"
  if ! rm -rf -- "$FINAL_CONFIG_DIR"; then
    echo "ERROR: Failed to remove existing directory: $FINAL_CONFIG_DIR" >&2
    exit 1
  fi
fi

# Ensure the parent directory of FINAL_CONFIG_DIR exists.
# This is important if FINAL_CONFIG_DIR is, for example, /mnt/persist/nixos and /mnt/persist might not exist yet.
PARENT_DIR_OF_FINAL_CONFIG="$(dirname "$FINAL_CONFIG_DIR")"
if [[ ! -d "$PARENT_DIR_OF_FINAL_CONFIG" ]]; then
  echo "INFO: Parent directory ${PARENT_DIR_OF_FINAL_CONFIG} for the final configuration does not exist. Creating..."
  if ! mkdir -p -- "$PARENT_DIR_OF_FINAL_CONFIG"; then
     echo "ERROR: Failed to create parent directory: $PARENT_DIR_OF_FINAL_CONFIG" >&2
     exit 1
  fi
fi

# Move the newly cloned configuration from the temporary directory to its final destination.
if ! mv -- "$TEMP_CLONE_DIR" "$FINAL_CONFIG_DIR"; then
  echo "ERROR: Failed to move '$TEMP_CLONE_DIR' to '$FINAL_CONFIG_DIR'." >&2
  exit 1
fi
echo "INFO: Successfully moved new configuration to ${FINAL_CONFIG_DIR}."

TEMP_CLONE_DIR_PATH_FOR_CLEANUP=""

readonly FLAKE_URI="${FINAL_CONFIG_DIR}#${FLAKE_TARGET_SYSTEM_NAME}"

echo "INFO: Starting NixOS installation..."
echo "INFO:   Root: $NIXOS_INSTALL_ROOT"
echo "INFO:   Flake: $FLAKE_URI"

if ! nixos-install --root "$NIXOS_INSTALL_ROOT" --flake "$FLAKE_URI"; then
  echo "ERROR: nixos-install command failed." >&2
  exit 1
fi

echo "SUCCESS: nixos-install command completed. The system will likely reboot if installation was successful."

exit 0