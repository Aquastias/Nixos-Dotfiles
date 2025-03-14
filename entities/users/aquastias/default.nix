{
  configVars,
  config,
  inputs,
  ...
}: let
  inherit (configVars) entities persistFolder secrets;
  userName = "aquastias";
  userEmail = "alexandrumlakar@gmail.com";
in {
  sops = {
    # This is the user key that needs to have been copied to this location on hosts
    age.keyFile = "${persistFolder}/home/${userName}/.config/sops/age/keys.txt";

    defaultSopsFile = "${secrets.path}";
    validateSopsFiles = false;

    secrets = {
      # Decrypt user password to /run/secrets-for-users so it can be used to its creation
      "${userName}-password" = {
        neededForUsers = true;
      };
      "private_keys/${userName}" = {
        path = "${persistFolder}/home/${userName}/.ssh/id_${userName}";
      };
    };
  };

  users = {
    # Required for password to be set via sops during system activation
    mutableUsers = false;
    users = {
      "${userName}" = {
        hashedPasswordFile = config.sops.secrets."${userName}-password".path;
        isNormalUser = true;
        description = "Aquastias";
        extraGroups = [
          "audio"
          "gpg" # For GnuPG
          "scanner" # To be able to see scanner devices
          "wheel" # Enable ‘sudo’ for the user.
        ];
      };
    };
  };

  home-manager = {
    users."${userName}" = {...}: {
      imports = [
        entities.home.path
        inputs.impermanence.homeManagerModules.impermanence
        inputs.sops-nix.homeManagerModules.sops
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
            ".config/sops"
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
