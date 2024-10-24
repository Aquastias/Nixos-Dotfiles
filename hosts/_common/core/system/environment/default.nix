{pkgs, ...}: {
  environment = {
    # List pkgs installed in system profile. To search, run:
    # $ nix search wget
    systemPackages = with pkgs; [
      home-manager

      alejandra
      curl
      nixd
      tree
      vim
      wget

      gnome.seahorse
    ];
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };
  };
}
