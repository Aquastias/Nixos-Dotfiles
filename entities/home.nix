{
  configVars,
  inputs,
  ...
}: {
  imports = [
    # Impermanence module
    inputs.impermanence.homeManagerModules.impermanence

    # Core stuff
    "${configVars.hosts.common.core.programs.path}/git"
    "${configVars.hosts.common.core.programs.path}/firefox"

    # Optional stuff
    "${configVars.hosts.common.optional.programs.path}/vscode"
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
    stateVersion = "${configVars.version}";
  };

  programs = {
    # Let Home Manager install and manage itself.
    home-manager = {
      enable = true;
    };
  };
}
