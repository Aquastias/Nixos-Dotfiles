{configVars, ...}: {
  fileSystems."${configVars.persistFolder}".neededForBoot = true;
}
