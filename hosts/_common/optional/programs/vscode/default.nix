{
  pkgs,
  config,
  lib,
  ...
}: let
  vscodePackage = config.programs.vscode.package.pname;
  configDirName =
    {
      "vscode" = "Code";
      "vscode-insiders" = "Code - Insiders";
      "vscodium" = "VSCodium";
    }
    .${config.programs.vscode.package.pname};
  userDir = "${config.xdg.configHome}/${configDirName}/User";
  backupPath = "${userDir}/settings.json.backup";
  configPath = "${userDir}/settings.json";
in {
  imports = [
    ./extensions.nix
    ./keybindings.nix
    ./user-settings.nix
  ];

  programs.vscode = {
    package = pkgs.vscodium;
    mutableExtensionsDir = false;
    enableUpdateCheck = false;
    enableExtensionUpdateCheck = false;
  };

  home.activation.removeVSCodeSettingsBackup = lib.mkIf (vscodePackage != null) {
    after = [];
    before = ["checkLinkTargets"];
    data = ''
      set -euo pipefail

      backupPath="${lib.escapeShellArgs [backupPath]}"

      if [[ -f "$backupPath" ]]; then
        rm -f "$backupPath"
        echo "Removed VS Code settings backup: $backupPath"
      else
        echo "VS Code settings backup not found: $backupPath"
      fi
    '';
  };

  home.activation.makeVSCodeConfigWritable = lib.mkIf (vscodePackage != null) {
    after = ["writeBoundary"];
    before = [];
    data = ''
      set -euo pipefail

      if [[ ! -L "${configPath}" ]]; then
        echo "Symlink ${configPath} does not exist."
        exit 0
      fi

      target=$(readlink "${configPath}")

      if [[ ! -f "$target" ]]; then
        echo "Target $target does not exist."
        exit 0
      fi

      current_perms=$(stat -c "%a" "${configPath}")

      if [[ "$current_perms" != "640" ]]; then
        install -m 0640 "$target" "${configPath}"
        echo "Permissions of ${configPath} set to 640."
      else
        echo "Permissions of ${configPath} are already 640."
      fi
    '';
  };
}
