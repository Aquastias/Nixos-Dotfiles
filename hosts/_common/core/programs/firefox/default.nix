{
  pkgs,
  lib,
  specialArgs,
  configVars,
  ...
}: {
  imports = [
    ./arkenfox
    ./bookmarks
    ./search
  ];

  programs.firefox = {
    # https://gitlab.com/engmark/root/-/blob/60468eb82572d9a663b58498ce08fafbe545b808/configuration.nix#L293-310
    # https://github.com/Kreyren/nixos-config/blob/bd4765eb802a0371de7291980ce999ccff59d619/nixos/users/kreyren/home/modules/web-browsers/firefox/firefox.nix
    # https://github.com/gvolpe/nix-config/blob/6feb7e4f47e74a8e3befd2efb423d9232f522ccd/home/programs/browsers/firefox.nix
    enable = true;

    languagePacks = ["en-US"];
    package = pkgs.firefox;
    policies = import ./policies {inherit configVars lib specialArgs;};
    profiles = {
      default = {
        id = 0;
        isDefault = true;
        name = "default";
        settings = import ./policies/preferences.nix {inherit configVars specialArgs;};
      };
    };
  };
}
