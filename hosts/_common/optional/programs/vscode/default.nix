{
  pkgs,
  config,
  lib,
  ...
}: let
  vscodePackage = config.programs.vscode.package;
  configDirName =
    lib.getAttr
    {
      "vscode" = "Code";
      "vscode-insiders" = "Code - Insiders";
      "vscodium" = "VSCodium";
    }
    (lib.getName vscodePackage);
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
    enableExtensionUpdateCheck = false;
    enableUpdateCheck = false;
    mutableExtensionsDir = false;
    package = pkgs.vscodium;
  };

  home.activation.removeVSCodeSettingsBackup = lib.mkIf (vscodePackage != null) {
    after = [];
    before = ["checkLinkTargets"];
    data = pkgs.writeShellScript "remove-vscode-settings-backup" ''
      set -euo pipefail

      backupPath="${backupPath}"

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
    data = pkgs.writeShellScript "make-vscode-settings-writable" ''
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
