{lib, ...}: {
  boot = {
    # Enable this temporarily before enabling the lanzaboote Secure Boot module.
    bootspec = {
      enable = true;
    };
    lanzaboote = {
      enable = true;
      pkiBundle = "/etc/secureboot";
    };
    loader = {
      efi = {
        canTouchEfiVariables = true;
      };
      systemd-boot = {
        # Lanzaboote currently replaces the systemd-boot module.
        enable = lib.mkForce false;
      };
    };
  };
}
