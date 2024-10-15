{ configVars, ... }:

{
  home = {
    enableNixpkgsReleaseCheck = false;

    imports =
      let
        optionalPrograms = configVars.hosts.optional.path.programs;
      in
      [ optionalPrograms.vscode ];

    # This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
    #
    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    stateVersion = "24.05";
  };

  programs = {
    # Let Home Manager install and manage itself.
    home-manager = {
      enable = true;
    };

    git = {
      extraConfig = {
        init.defaultBranch = "main";
        safe.directory = "/etc/nixos";
      };
    };

    firefox = {
      enable = true;
    };
  };
}
