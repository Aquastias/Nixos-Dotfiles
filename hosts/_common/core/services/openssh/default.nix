{configVars, ...}: let
  inherit (configVars) sshDir;
in {
  services = {
    openssh = {
      enable = true;
      hostKeys = [
        {
          path = "${sshDir}/ssh_host_ed25519_key";
          type = "ed25519";
        }
        {
          bits = 4096;
          path = "${sshDir}/ssh_host_rsa_key";
          type = "rsa";
        }
      ];
      ports = [22];
      settings = {
        Ciphers = [
          "aes256-ctr"
          "aes192-ctr"
          "aes128-ctr"
        ];
        KbdInteractiveAuthentication = false;
        KexAlgorithms = [
          "diffie-hellman-group-exchange-sha256"
          "diffie-hellman-group14-sha256"
        ];
        Macs = [
          "hmac-sha2-256"
          "hmac-sha2-512"
        ];
        PasswordAuthentication = false;
        PermitRootLogin = "no";
      };
      startWhenNeeded = false;
    };
  };
}
