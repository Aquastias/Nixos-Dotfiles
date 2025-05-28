#!/usr/bin/env bash

set -eo pipefail

readonly GIT_REPO_URL="https://github.com/Aquastias/Vault.git"
readonly ARCHIVE_NAME="Git-SSH.tar.gz"
readonly AGE_ENCRYPTED_FILENAME="${ARCHIVE_NAME}.enc.age"
readonly OPENSSL_ENCRYPTED_FILENAME="${ARCHIVE_NAME}.enc"
readonly SSH_DIR="/root/.ssh"

TEMP_VAULT_DIR=""

source ./helpers/check-root-privileges.sh
source ./helpers/cleanup-temp-dir.sh

_main_script_cleanup() {
  cleanup_temp_dir "$TEMP_VAULT_DIR"
}

trap _main_script_cleanup EXIT

check_root_privileges

echo "Preparing SSH directory: $SSH_DIR ..."
mkdir -p "$SSH_DIR"
chmod 700 "$SSH_DIR"

TEMP_VAULT_DIR=$(mktemp -d)
echo "Cloning credentials from $GIT_REPO_URL into temporary directory $TEMP_VAULT_DIR ..."

if ! git clone --depth=1 "$GIT_REPO_URL" "$TEMP_VAULT_DIR"; then
  echo "ERROR: Failed to clone Git repository from $GIT_REPO_URL." >&2
  exit 1 
fi

readonly AGE_INPUT_FILE="${TEMP_VAULT_DIR}/ssh/git/${AGE_ENCRYPTED_FILENAME}"
readonly OPENSSL_INPUT_FILE="${TEMP_VAULT_DIR}/ssh/git/${OPENSSL_ENCRYPTED_FILENAME}" 

if [[ ! -f "$AGE_INPUT_FILE" ]]; then
  echo "ERROR: Expected age-encrypted file not found after cloning: $AGE_INPUT_FILE" >&2
  exit 1
fi

echo "Decrypting credentials..."
if ! nix-shell -p age openssl --run "
  set -e; # Ensure commands inside nix-shell also exit on error
  echo '--> Step 1: Decrypting with age: ${AGE_INPUT_FILE} -> ${OPENSSL_INPUT_FILE}';
  age -d -o \"${OPENSSL_INPUT_FILE}\" \"${AGE_INPUT_FILE}\";

  echo '--> Step 2: Decrypting with OpenSSL and extracting to ${SSH_DIR}...';
  openssl enc -aes-256-cbc -d -pbkdf2 -iter 100000 -salt -in \"${OPENSSL_INPUT_FILE}\" | tar xzf - -C \"${SSH_DIR}\";
"; then
  echo "ERROR: Decryption or extraction process failed." >&2
  exit 1 
fi

echo "Setting secure permissions for contents of $SSH_DIR ..."
chmod 700 "$SSH_DIR"
find "$SSH_DIR" -type d -exec chmod 700 {} \;
find "$SSH_DIR" -type f -exec chmod 600 {} \;
chown -R root:users "$SSH_DIR/config" "$SSH_DIR/keys"

echo "SSH credentials successfully processed and installed in $SSH_DIR."
echo "Temporary files in $TEMP_VAULT_DIR will be (or have been) cleaned up by the trap."

exit 0