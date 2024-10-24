{pkgs, ...}: {
  environment = {
    # List packages installed in system profile. To search, run:
    # $ nix search wget
    systemPackages = let
      packages = pkgs;
      gnome = pkgs.gnome;
    in
      builtins.attrValues {
        home-manager = packages.home-manager;
        vim = packages.vim;
        wget = packages.wget;
        curl = packages.curl;
        nixd = packages.nixd;
        alejandra = packages.alejandra;
        seahorse = gnome.seahorse;
      };
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };
  };
}
