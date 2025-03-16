{
  configVars,
  config,
  inputs,
  ...
}: let
  inherit (configVars) entities persistFolder secrets;
  userName = "aquastias";
  userEmail = "alexandrumlakar@gmail.com";
  homeDir = "/home/${userName}";
  homeSopsAgeDir = "${persistFolder}${homeDir}/.config/sops/age";
in {
  environment.sessionVariables = {
    SOPS_AGE_KEY_FILE = "${homeSopsAgeDir}/keys.txt";
  };

  sops = {
    # # This is the user key that needs to have been copied to this location on hosts
    age = {
      keyFile = "${homeSopsAgeDir}/keys.txt";
    };

    defaultSopsFile = secrets.path;
    validateSopsFiles = false;

    secrets = {
      # Decrypt user password to /run/secrets-for-users
      # so it can be used to its creation
      "${userName}-password" = {
        neededForUsers = true;
      };
      "private_keys/${userName}" = {
        mode = "0600";
        owner = "${userName}";
        path = "${persistFolder}${homeDir}/.ssh/id_${userName}";
        sopsFile = secrets.path;
      };
    };
  };

  system.activationScripts."homeAgeKeysFolderPermissionsFor${userName}" = ''
    mkdir -p ${homeSopsAgeDir}
    chown -R ${userName}:users ${homeSopsAgeDir}
  '';

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
      ];

      home = {
        username = userName;
        homeDirectory = "${homeDir}";

        persistence."${persistFolder}${homeDir}" = {
          directories = [
            "Desktop"
            "Documents"
            "Downloads"
            "Music"
            "Pictures"
            "Public"
            "Templates"
            "Videos"
            ".config/sops/age"
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
