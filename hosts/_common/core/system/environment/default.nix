{
  pkgs,
  configVars,
  ...
}: let
  inherit (configVars) disko persistFolder;
  inherit (disko) systemDir;
in {
  environment = {
    # Backup to persistence directory so that files don't get removed at reboot
    persistence = {
      "${persistFolder}/${systemDir}" = {
        hideMounts = true;
        directories = [
          "/etc/nixos"
          "/etc/NetworkManager/system-connections"
          "/etc/ssh"
          "/var/log"
          "/var/lib/bluetooth"
          "/var/lib/nixos"
          "/var/lib/systemd/coredump"
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

      age
      alejandra
      coreutils-full
      curl
      jq
      libbs2b
      nh
      nix-output-monitor
      nixd
      nvd
      openssl
      sbctl
      seahorse
      sops
      tree
      vim
      wget
      zfs
    ];
    sessionVariables = {
      FLAKE = "${persistFolder}/nixos";
      NIXOS_OZONE_WL = "1";
    };
  };
}
