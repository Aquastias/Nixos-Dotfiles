{
  pkgs,
  config,
  ...
}: {
  imports = [
    ./extensions.nix
    ./keybindings.nix
    ./user-settings.nix
  ];

  home.activation.removeVSCodeSettingsBackup = let
    configDirName =
      {
        "vscode" = "Code";
        "vscode-insiders" = "Code - Insiders";
        "vscodium" = "VSCodium";
      }
      .${config.programs.vscode.package.pname};
  in {
    after = [];
    before = ["checkLinkTargets"];
    data = ''
      userDir=${config.xdg.configHome}/${configDirName}/User
      rm -rf $userDir/settings.json.backup
    '';
  };

  home.activation.makeVSCodeConfigWritable = let
    configDirName =
      {
        "vscode" = "Code";
        "vscode-insiders" = "Code - Insiders";
        "vscodium" = "VSCodium";
      }
      .${config.programs.vscode.package.pname};
    configPath = "${config.xdg.configHome}/${configDirName}/User/settings.json";
  in {
    after = ["writeBoundary"];
    before = [];
    data = ''
      install -m 0640 "$(readlink ${configPath})" ${configPath}
    '';
  };

  programs.vscode = {
    package = pkgs.vscodium;
    mutableExtensionsDir = false;
    enableUpdateCheck = false;
    enableExtensionUpdateCheck = false;
  };
}
