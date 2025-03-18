{
  configVars,
  config,
  inputs,
  ...
}: let
  inherit (configVars) entities persistDir secrets;

  user = {
    name = "aquastias";
    email = config.sops.secrets."${user.name}-email".path;
  };
  homeDir = "/home/${user.name}";
  homeSopsAgeDir = "${persistDir}${homeDir}/.config/sops/age";
in {
  environment = {
    sessionVariables = {
      SOPS_AGE_KEY_FILE = "${homeSopsAgeDir}/keys.txt";
    };
  };

  home-manager = {
    users."${user.name}" = {...}: {
      imports = [
        entities.home.path
        inputs.impermanence.homeManagerModules.impermanence
      ];

      home = {
        homeDirectory = "${homeDir}";
        persistence."${persistDir}${homeDir}" = {
          allowOther = true;
          directories = [
            "Desktop"
            "Documents"
            "Downloads"
            "Music"
            "Pictures"
            "Public"
            "Templates"
            "Videos"
            ".config"
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
        };
        username = user.name;
      };

      programs = {
        git = {
          userEmail = user.email;
          userName = user.name;
        };

        vscode = {
          enable = true;
        };
      };
    };
  };

  sops = {
    # This is the user key that needs to have been copied to this location on hosts
    age = {
      keyFile = "${homeSopsAgeDir}/keys.txt";
    };
    defaultSopsFile = secrets.path;
    secrets = {
      # Decrypt user password to /run/secrets-for-users
      # so it can be used to its creation
      "${user.name}-password" = {
        neededForUsers = true;
      };
      "private_keys/${user.name}" = {
        mode = "0600";
        owner = "${user.name}";
        path = "${persistDir}${homeDir}/.ssh/id_${user.name}";
        sopsFile = secrets.path;
      };
    };
    validateSopsFiles = false;
  };

  system = {
    activationScripts = {
      "homeAgeKeysFolderPermissionsFor${user.name}" = ''
        mkdir -p ${homeSopsAgeDir}
        chown -R ${user.name}:users ${homeSopsAgeDir}
      '';
    };
  };

  users = {
    # Required for password to be set via sops during system activation
    mutableUsers = false;
    users = {
      "${user.name}" = {
        description = "Aquastias";
        extraGroups = [
          "audio"
          "gpg" # For GnuPG
          "scanner" # To be able to see scanner devices
          "wheel" # Enable ‘sudo’ for the user.
        ];
        hashedPasswordFile = config.sops.secrets."${user.name}-password".path;
        isNormalUser = true;
      };
    };
  };
}
