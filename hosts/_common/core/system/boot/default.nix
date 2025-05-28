{
  lib,
  configVars,
  ...
}: {
  boot = {
    bootspec = {
      enable = true;
    };
    initrd = {
      postResumeCommands = lib.mkAfter ''
        zfs rollback -r zroot/${configVars.disko.systemDirName}/root@blank
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
      allowHibernation = false;
      devNodes = "/dev/disk/by-partuuid";
    };
  };
}
