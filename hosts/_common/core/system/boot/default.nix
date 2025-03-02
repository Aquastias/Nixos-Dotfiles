{lib, ...}: {
  boot = {
    bootspec = {
      enable = true;
    };
    initrd = {
      postResumeCommands = lib.mkAfter ''
        zfs rollback -r zroot/local/root@blank
      '';
    };
    loader = {
      efi = {
        canTouchEfiVariables = true;
      };
      systemd-boot = {
        enable = lib.mkForce true;
      };
    };
    supportedFilesystems = {
      btrfs = false;
      zfs = lib.mkForce true;
    };
    zfs = {
      devNodes = "/dev/disk/by-partuuid";
    };
  };
}
