{configVars, ...}: {
  programs.git = {
    enable = true;
    extraConfig = {
      init.defaultBranch = "main";
      safe.directory = "${configVars.persistDir}/nixos";
    };
  };
}
