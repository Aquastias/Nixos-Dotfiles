{
  configVars,
  inputs,
  ...
}: let
  inherit (configVars) persistDir disko sshDir;
  inherit (disko) systemDir;

  secretsPath = builtins.toString inputs.my-secrets;
in {
  sops = {
    defaultSopsFile = "${secretsPath}/secrets.yaml";
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
