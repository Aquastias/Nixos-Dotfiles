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
    };
    # List pkgs installed in system profile. To search, run:
    # $ nix search wget
    systemPackages = with pkgs; [
      home-manager

      alejandra
      curl
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
      FLAKE = "/etc/nixos";
      NIXOS_OZONE_WL = "1";
    };
  };
}
