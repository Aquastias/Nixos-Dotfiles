{configVars, ...}: let
  inherit (configVars) disko persistFolder;
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
    "${persistFolder}" = {
      device = "zroot/${systemDir}${persistFolder}";
      fsType = "zfs";
      neededForBoot = true;
    };
  };
}
