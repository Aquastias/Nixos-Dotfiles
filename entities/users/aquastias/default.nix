{
  configVars,
  inputs,
  ...
}: let
  inherit (configVars) persistFolder entities;
  userName = "aquastias";
  userEmail = "alexandrumlakar@gmail.com";
in {
  users.users."${userName}" = {
    initialPassword = "password";
    isNormalUser = true;
    description = "Aquastias";
    extraGroups = [
      "audio"
      "gpg" # For GnuPG
      "scanner" # To be able to see scanner devices
      "wheel" # Enable ‘sudo’ for the user.
    ];
  };

  home-manager = {
    users."${userName}" = {...}: {
      imports = [
        entities.home.path
        inputs.impermanence.homeManagerModules.impermanence
      ];

      home = {
        username = userName;
        homeDirectory = "/home/${userName}";

        persistence."${persistFolder}/home/${userName}" = {
          directories = [
            "Desktop"
            "Documents"
            "Downloads"
            "Music"
            "Pictures"
            "Public"
            "Templates"
            "Videos"
            ".gnupg"
            ".ssh"
            ".mozilla"
            ".vscode-oss"
            ".local/share/keyrings"
            ".local/share/direnv"
            {
              directory = ".local/share/Steam";
              method = "symlink";
            }
          ];
          files = [
            ".screenrc"
          ];
          allowOther = true;
        };
      };

      programs = {
        git = {
          inherit userEmail userName;
        };

        vscode = {
          enable = true;
        };
      };
    };
  };
}
