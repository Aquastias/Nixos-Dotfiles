{ pkgs, ... }:

{
  environment = {
    # List packages installed in system profile. To search, run:
    # $ nix search wget
    systemPackages =
      let
        packages = pkgs;
        gnome = pkgs.gnome;
      in
      builtins.attrValues {
        home-manager = packages.home-manager;
        vim = packages.vim;
        wget = packages.wget;
        curl = packages.curl;
        nil = packages.nil;
        nixfmt-rfc-style = packages.nixfmt-rfc-style;
        seahorse = gnome.seahorse;
      };
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };
  };
}
