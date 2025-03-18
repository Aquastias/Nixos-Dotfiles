{configVars, ...}: let
  inherit (configVars) disko persistDir;
  inherit (disko) systemDir;
in {
  fileSystems = {
    "/" = {
      device = "zroot/${systemDir}/root";
      fsType = "zfs";
    };
    "/home" = {
      device = "zroot/${systemDir}/home";
      fsType = "zfs";
    };
    "/nix" = {
      device = "zroot/${systemDir}/nix";
      fsType = "zfs";
      neededForBoot = true;
    };
    # SOPS will use the host SSH keys to decrypt secrets
    "/etc/ssh" = {
      neededForBoot = true;
    };
    "${persistDir}" = {
      device = "zroot/${systemDir}${persistDir}";
      fsType = "zfs";
      neededForBoot = true;
    };
  };
}
