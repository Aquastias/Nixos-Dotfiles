{configVars, ...}: {
  programs.git = {
    enable = true;
    extraConfig = {
      init.defaultBranch = "main";
      safe.directory = "${configVars.persistFolder}/nixos";
    };
  };
}
