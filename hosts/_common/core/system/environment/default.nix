{
  pkgs,
  configVars,
  ...
}: {
  environment = {
    # Backup to persistence directory so that files don't get removed at reboot
    persistence = {
      "${configVars.persistFolder}/system" = {
        hideMounts = true;
        directories = [
          "/etc/nixos"
          "/var/log"
          "/var/lib/bluetooth"
          "/var/lib/nixos"
          "/var/lib/systemd/coredump"
          "/etc/NetworkManager/system-connections"
          {
            directory = "/var/lib/colord";
            user = "colord";
            group = "colord";
            mode = "u=rwx,g=rx,o=";
          }
        ];
        files = [
          "/etc/machine-id"
          {
            file = "/var/keys/secret_file";
            parentDirectory = {mode = "u=rwx,g=,o=";};
          }
        ];
      };
      "${configVars.persistFolder}".users = {
        aquastias = {
          directories = [
            "Desktop"
            "Documents"
            "Downloads"
            "Music"
            "Pictures"
            "Public"
            "Templates"
            "Videos"
            {
              directory = ".gnupg";
              mode = "0700";
            }
            {
              directory = ".ssh";
              mode = "0700";
            }
            {
              directory = ".nixops";
              mode = "0700";
            }
            {
              directory = ".local/share/keyrings";
              mode = "0700";
            }
            ".local/share/direnv"
          ];
          files = [
            ".screenrc"
          ];
        };
      };
    };
    # List pkgs installed in system profile. To search, run:
    # $ nix search wget
    systemPackages = with pkgs; [
      home-manager

      alejandra
      curl
      jq
      libbs2b
      nh
      nixd
      nix-output-monitor
      nvd
      openssl
      sbctl
      tree
      vim
      wget
      seahorse
      coreutils-full
      zfs
    ];
    sessionVariables = {
      FLAKE = "${configVars.persistFolder}/nixos";
      NIXOS_OZONE_WL = "1";
    };
  };
}
