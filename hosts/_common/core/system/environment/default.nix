{pkgs, ...}: {
  environment = {
    # List pkgs installed in system profile. To search, run:
    # $ nix search wget
    systemPackages = with pkgs; [
      home-manager

      alejandra
      curl
      nh
      nixd
      nix-output-monitor
      nvd
      openssl
      sbctl
      tree
      vim
      wget

      gnome.seahorse
    ];
    sessionVariables = {
      FLAKE = "/etc/nixos";
      NIXOS_OZONE_WL = "1";
    };
  };
}
