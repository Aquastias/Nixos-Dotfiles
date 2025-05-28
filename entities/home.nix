{configVars, ...}: let
  inherit (configVars) hosts version;
  inherit (hosts.common) core optional;
in {
  imports = [
    # Core stuff
    "${core.programs.path}/git"
    "${core.programs.path}/firefox"
    "${core.programs.path}/ssh"

    # Optional stuff
    "${optional.programs.path}/vscode"
  ];

  home = {
    enableNixpkgsReleaseCheck = false;

    # This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
    #
    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    stateVersion = "${version}";
  };

  programs = {
    # Let Home Manager install and manage itself.
    home-manager = {
      enable = true;
    };
  };
}
