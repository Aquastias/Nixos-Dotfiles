{ ... }:

{
  services = {
    openssh = {
      enable = true;
      extraConfig = ''
        # Disable password authentication
        PasswordAuthentication no

        # Use only strong ciphers and key exchange algorithms
        Ciphers aes256-ctr,aes192-ctr,aes128-ctr
        KexAlgorithms diffie-hellman-group-exchange-sha256,diffie-hellman-group14-sha256
        MACs hmac-sha2-256,hmac-sha2-512
      '';
      ports = [ 22 ];
      settings = {
        PermitRootLogin = "no";
      };
    };
  };
}
