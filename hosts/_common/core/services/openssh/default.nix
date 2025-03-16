{configVars, ...}: let
  inherit (configVars) disko persistFolder;
  inherit (disko) systemDir;

  sshKeyDir = "${persistFolder}/${systemDir}/etc/ssh";
in {
  services = {
    openssh = {
      enable = true;
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

  systemd.services.openssh.after = ["network.target"];
  systemd.services.openssh.wants = ["network-online.target"];
  systemd.services.openssh.before = ["sops-nix.service"];
  systemd.services.openssh.requires = ["disko.service"];
  systemd.services.sops-nix = {
    serviceConfig = {
      Restart = "on-failure";
      RestartSec = "10";
    };
  };
}
