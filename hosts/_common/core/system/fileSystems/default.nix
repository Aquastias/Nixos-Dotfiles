{configVars, ...}: {
  fileSystems = {
    "/".neededForBoot = true;
    "/nix".neededForBoot = true;
    "${configVars.persistFolder}".neededForBoot = true;
  };
}
