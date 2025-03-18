{configVars, ...}: let
  inherit (configVars) disko persistDir;
  inherit (disko) systemDirName;
in {
  fileSystems = {
    "/" = {
      device = "zroot/${systemDirName}/root";
      fsType = "zfs";
    };
    "/home" = {
      device = "zroot/${systemDirName}/home";
      fsType = "zfs";
    };
    "/nix" = {
      device = "zroot/${systemDirName}/nix";
      fsType = "zfs";
      neededForBoot = true;
    };
    # SOPS will use the host SSH keys to decrypt secrets
    "/etc/ssh" = {
      neededForBoot = true;
    };
    "${persistDir}" = {
      device = "zroot/${systemDirName}${persistDir}";
      fsType = "zfs";
      neededForBoot = true;
    };
  };
}
