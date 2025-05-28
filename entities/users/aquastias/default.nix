{
  configVars,
  config,
  inputs,
  ...
}: let
  inherit (configVars) entities persistDir;

  homeDir = "/home/${user.name}";
  homePersistDir = "${persistDir}${homeDir}";

  secretsPath = builtins.toString inputs.my-secrets;

  user = {
    email = config.sops.secrets."${user.name}-email".path;
    name = "aquastias";
  };
in {
  home-manager = {
    users."${user.name}" = {...}: {
      imports = [
        entities.home.path
        inputs.impermanence.homeManagerModules.impermanence
      ];

      home = {
        homeDirectory = "${homeDir}";
        persistence."${homePersistDir}" = {
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

        ssh = {
          matchBlocks = {
            "identity_${user.name}" = {
              host = "github.com";
              identitiesOnly = true;
              identityFile = [
                "~/.ssh/id_${user.name}"
              ];
            };
          };
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
      keyFile = "/persist/sops-nix/age/keys.txt";
    };
    defaultSopsFile = "${secretsPath}/secrets.yaml";
    secrets = {
      # Decrypt user password to /run/secrets-for-users
      # so it can be used to its creation
      "${user.name}-password" = {
        neededForUsers = true;
      };
      # Decrypt user email to /run/secrets-for-users
      # so it can be used for programs that need it
      "${user.name}-email" = {
        neededForUsers = true;
      };
      "private_keys/${user.name}" = {
        mode = "0600";
        owner = "${user.name}";
        path = "${homePersistDir}/.ssh/id_${user.name}";
        sopsFile = "${secretsPath}/secrets.yaml";
      };
    };
    validateSopsFiles = false;
  };

  users = {
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
