#!/usr/bin/env bash

set -eo pipefail

readonly GIT_REPO_URL="git@github.com/Aquastias/Nixos-Secrets.git"
readonly AGE_ENCRYPTED_FILENAME_IN_REPO="keys.txt.age"
readonly DECRYPTED_FILENAME="keys.txt"              
readonly TARGET_KEY_DIR="/mnt/persist/sops-nix/age"
readonly TARGET_KEY_FILE="${TARGET_KEY_DIR}/${DECRYPTED_FILENAME}"
readonly TARGET_KEY_DIR_PERMS="0700" 
readonly TARGET_KEY_FILE_PERMS="0400"

source ./helpers/check-root-privileges.sh
source ./helpers/cleanup-temp-dir.sh

TEMP_SECRETS_DIR="" 

_main_script_cleanup() {
  cleanup_temp_dir "$TEMP_SECRETS_DIR" 
}

trap _main_script_cleanup EXIT 

check_root_privileges

echo "INFO: Preparing SOPS key directory: $TARGET_KEY_DIR ..."
mkdir -p "$TARGET_KEY_DIR"

PARENT_OF_TARGET_KEY_DIR="$(dirname "$TARGET_KEY_DIR")"
if [[ -d "$PARENT_OF_TARGET_KEY_DIR" && "$PARENT_OF_TARGET_KEY_DIR" != "/" && "$PARENT_OF_TARGET_KEY_DIR" != "." ]]; then
    echo "INFO: Setting permissions ${TARGET_KEY_DIR_PERMS} for ${PARENT_OF_TARGET_KEY_DIR}..."
    chmod "${TARGET_KEY_DIR_PERMS}" "$PARENT_OF_TARGET_KEY_DIR"
fi
echo "INFO: Setting permissions ${TARGET_KEY_DIR_PERMS} for ${TARGET_KEY_DIR}..."
chmod "${TARGET_KEY_DIR_PERMS}" "$TARGET_KEY_DIR"

TEMP_SECRETS_DIR=$(mktemp -d)
if [[ -z "$TEMP_SECRETS_DIR" || ! -d "$TEMP_SECRETS_DIR" ]]; then
  echo "ERROR: Failed to create temporary directory." >&2
  exit 1
fi
echo "INFO: Cloning secrets from $GIT_REPO_URL into temporary directory $TEMP_SECRETS_DIR ..."

if ! git clone --depth=1 "$GIT_REPO_URL" "$TEMP_SECRETS_DIR"; then
  echo "ERROR: Failed to clone Git repository from $GIT_REPO_URL." >&2
  exit 1 
fi

readonly CLONED_AGE_FILE="${TEMP_SECRETS_DIR}/${AGE_ENCRYPTED_FILENAME_IN_REPO}"
readonly DECRYPTED_KEY_IN_TEMP="${TEMP_SECRETS_DIR}/${DECRYPTED_FILENAME}"

if [[ ! -f "$CLONED_AGE_FILE" ]]; then
  echo "ERROR: Expected age-encrypted file not found after cloning: $CLONED_AGE_FILE" >&2
  exit 1 
fi

echo "INFO: Decrypting SOPS key file ${CLONED_AGE_FILE}..."
# The age command will prompt for a password if the file was encrypted with one,
# or use available age identities (e.g., in /root/.config/age/keys.txt if run as root).
if ! nix-shell -p age --run "
  set -e; # Ensure commands inside nix-shell also exit on error
  echo '--> Decrypting with age: ${CLONED_AGE_FILE} -> ${DECRYPTED_KEY_IN_TEMP}';
  age -d -o \"${DECRYPTED_KEY_IN_TEMP}\" \"${CLONED_AGE_FILE}\";
"; then
  echo "ERROR: Age decryption failed for ${CLONED_AGE_FILE}." >&2
  exit 1 
fi

if [[ ! -f "$DECRYPTED_KEY_IN_TEMP" ]]; then
  echo "ERROR: Decrypted key file not found: $DECRYPTED_KEY_IN_TEMP. Decryption may have failed silently or produced no output." >&2
  exit 1
fi

echo "INFO: Installing decrypted key to $TARGET_KEY_FILE with permissions ${TARGET_KEY_FILE_PERMS}..."
# Use 'install' to copy the file and set permissions atomically.
# This also allows setting ownership if needed in the future (with -o owner -g group options).
if ! install -m "${TARGET_KEY_FILE_PERMS}" "${DECRYPTED_KEY_IN_TEMP}" "${TARGET_KEY_FILE}"; then
  echo "ERROR: Failed to install decrypted key to ${TARGET_KEY_FILE}." >&2
  exit 1 
fi

echo "SUCCESS: SOPS key successfully decrypted and installed to $TARGET_KEY_FILE."
echo "INFO: Temporary files in $TEMP_SECRETS_DIR will be cleaned up by the trap mechanism."

exit 0