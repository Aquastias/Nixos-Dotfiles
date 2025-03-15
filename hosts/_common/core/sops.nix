{
  inputs,
  configVars,
  ...
}: {
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  sops = {
    defaultSopsFile = "${configVars.secrets.path}";
    validateSopsFiles = false;

    age = {
      # Automatically import host SSH key as age keys
      sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
      # This will use an age key that is already expected to be in the filesystem
      keyFile = "/var/lib/sops-nix/key.txt";
      # Generate a new key if the key specified above does not exist
      generateKey = true;
    };
  };
}
