{ pkgs, ... }:

{
  environment = {
    # List packages installed in system profile. To search, run:
    # $ nix search wget
    systemPackages =
      let
        gnome = pkgs.gnome;
      in
      builtins.attrValues {
        home-manager = pkgs.home-manager;
        vim = pkgs.vim;
        wget = pkgs.wget;
        curl = pkgs.curl;
        nil = pkgs.nil;
        nixfmt-rfc-style = pkgs.nixfmt-rfc-style;
        seahorse = gnome.seahorse;
      };
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };
  };
}
