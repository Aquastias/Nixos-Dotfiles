{ pkgs, configVars, ... }:

let
  userName = "aquastias";
  userEmail = "alexandrumlakar@gmail.com";
in
{
  users.users."${userName}" = {
    isNormalUser = true;
    description = "Mlakar Alexandru Laurian";
    extraGroups = [
      "wheel" # Enable ‘sudo’ for the user.
      "gpg" # For GnuPG
      "scanner" # To be able to see scanner devices
    ];
    packages = builtins.attrValues { inherit (pkgs) firefox tree; };
  };

  home-manager = {
    home = {
      username = userName;
      homeDirectory = "/home/${userName}";
    };
    users.aquastias = {
      imports = [
        configVars.users.home.path
        "${configVars.hosts.common.optional.path.programs}/vscode"
      ];
    };
    programs = {
      git = {
        inherit userEmail userName;
      };
    };
  };
}
