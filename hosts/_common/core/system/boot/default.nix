{lib, ...}: {
  boot = {
    bootspec = {
      enable = true;
    };
    loader = {
      efi = {
        canTouchEfiVariables = true;
      };
      systemd-boot = {
        enable = lib.mkForce true;
      };
    };
  };
}
