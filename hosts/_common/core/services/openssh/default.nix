{configVars, ...}: let
  inherit (configVars) disko persistFolder;
  inherit (disko) systemDir;
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
          path = "${persistFolder}/${systemDir}/etc/ssh/ssh_host_ed25519_key";
          type = "ed25519";
        }
        {
          bits = 4096;
          path = "${persistFolder}/${systemDir}/etc/ssh/ssh_host_rsa_key";
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
    };
  };
  system.activationScripts.persist-ssh-keys.text = ''
    mkdir -p "${persistFolder}/${systemDir}"

    # Check for and generate RSA key
    if [ ! -e "${persistFolder}/${systemDir}/ssh_host_rsa_key" ]; then
      ssh-keygen -t rsa -b 4096 -f "${persistFolder}/${systemDir}/ssh_host_rsa_key" -N ""
    fi

    # Check for and generate ED25519 key
    if [ ! -e "${persistFolder}/${systemDir}/ssh_host_ed25519_key" ]; then
      ssh-keygen -t ed25519 -f "${persistFolder}/${systemDir}/ssh_host_ed25519_key" -N ""
    fi

    mount --bind "${persistFolder}/${systemDir}" /etc/ssh
  '';
  system.activationScripts.persist-ssh-keys.before = ["sops-nix.service"];
}
