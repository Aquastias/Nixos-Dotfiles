{configVars, ...}: let
  inherit (configVars) disko persistDir secrets sshDir;
  inherit (disko) systemDir;
in {
  sops = {
    defaultSopsFile = secrets.path;
    gnupg.sshKeyPaths = [];
    validateSopsFiles = false;

    age = {
      # This will use an age key that is already expected to be in the filesystem
      keyFile = "${persistDir}${systemDir}/var/lib/sops-nix/key.txt";
      # Generate a new key if the key specified above does not exist
      generateKey = true;
      # Automatically import host SSH keys as age keys
      # This needs to be the /persist path,
      # or else it wont be available when needed to create user passwords etc
      sshKeyPaths = [
        "${sshDir}/ssh_host_ed25519_key"
        "${sshDir}/ssh_host_rsa_key"
      ];
    };
  };
}
