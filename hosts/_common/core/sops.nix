{
  inputs,
  configVars,
  ...
}: let
  inherit (configVars) disko persistFolder secrets;
  inherit (disko) systemDir;
in {
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  sops = {
    defaultSopsFile = "${secrets.path}";
    validateSopsFiles = false;

    age = {
      # This will use an age key that is already expected to be in the filesystem
      keyFile = "/var/lib/sops-nix/key.txt";
      # Generate a new key if the key specified above does not exist
      generateKey = true;
      # Automatically import host SSH key as age keys
      # This needs to be the /persist path,
      # or else it wont be available when needed to create user passwords etc
      sshKeyPaths = ["${persistFolder}/${systemDir}/etc/ssh/ssh_host_ed25519_key"];
    };
  };
}
