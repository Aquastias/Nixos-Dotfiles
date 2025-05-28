#!/usr/bin/env bash

set -eo pipefail

readonly DISKO_FLAKE_VERSION="latest" 
readonly DISKO_FLAKE_URI="github:nix-community/disko/${DISKO_FLAKE_VERSION}"
readonly DISKO_MODE="destroy,format,mount"
readonly DISKO_CONFIG_FILENAME="disko-config.nix"

source ./helpers/check-root-privileges.sh

check_root_privileges 

readonly DISKO_CONFIG_FILE_PATH="../${DISKO_CONFIG_FILENAME}"

echo "INFO: Preparing disk layout and filesystems using Disko."
echo "INFO:   Disko Flake: ${DISKO_FLAKE_URI}"
echo "INFO:   Disko Mode: ${DISKO_MODE}"
echo "INFO:   Disko Configuration File: ${DISKO_CONFIG_FILE_PATH}"
echo ""
echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
echo "WARNING: This script will invoke Disko with '--mode ${DISKO_MODE}'"
echo "         and '--yes-wipe-all-disks'."
echo "WARNING: THIS IS A HIGHLY DESTRUCTIVE OPERATION AND WILL IRREVERSIBLY WIPE DISKS"
echo "         as defined in '${DISKO_CONFIG_FILENAME}'."
echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
echo ""

if [[ ! -f "$DISKO_CONFIG_FILE_PATH" ]]; then
  echo "ERROR: Disko configuration file not found at the expected location: $DISKO_CONFIG_FILE_PATH" >&2
  echo "Please ensure the file exists and the path derivation logic in the script is correct." >&2
  exit 1
fi

# Safety Pause: Give the user a chance to abort, even with disko's own --yes flag.
# For fully automated, non-interactive scripts, you might remove this
# or make it conditional (e.g., skip if a '--force-script' flag is passed to this script).
echo "INFO: Proceeding with Disko execution in 5 seconds. Press Ctrl+C NOW to abort."
sleep 1; echo "INFO: 4 seconds..."
sleep 1; echo "INFO: 3 seconds..."
sleep 1; echo "INFO: 2 seconds..."
sleep 1; echo "INFO: 1 second..."
echo "INFO: Executing Disko..."

if ! nix --experimental-features "nix-command flakes" \
    run "${DISKO_FLAKE_URI}" -- \
    --mode "${DISKO_MODE}" \
    "${DISKO_CONFIG_FILE_PATH}" \
    --yes-wipe-all-disks; then
  echo "ERROR: Disko command execution failed." >&2
  exit 1
fi

echo "SUCCESS: Disko command completed."
echo "INFO: Disk layout and filesystems should now be prepared according to '${DISKO_CONFIG_FILENAME}'."

exit 0