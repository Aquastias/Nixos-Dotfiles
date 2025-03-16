{configVars, ...}: let
  inherit (configVars) disko persistFolder;
  inherit (disko) systemDir;

  sshKeyDir = "${persistFolder}/${systemDir}/etc/ssh";
in {
  services = {
    openssh = {
      enable = true;
      extraConfig = ''
        # Use only strong ciphers and key exchange algorithms
        Ciphers aes256-ctr,aes192-ctr,aes128-ctr
        KexAlgorithms diffie-hellman-group-exchange-sha256,diffie-hellman-group14-sha256
        MACs hmac-sha2-256,hmac-sha2-512
      '';
      hostKeys = [
        {
          path = "${sshKeyDir}/ssh_host_ed25519_key";
          type = "ed25519";
        }
        {
          bits = 4096;
          path = "${sshKeyDir}/ssh_host_rsa_key";
          type = "rsa";
        }
      ];
      ports = [22];
      settings = {
        KbdInteractiveAuthentication = false;
        PasswordAuthentication = false;
        PermitRootLogin = "no";
      };
      startWhenNeeded = false;
      unitConfig = {
        Before = "sops-nix.service";
        After = "network.target";
      };
    };
  };
}
