{...}: {
  programs.git = {
    enable = true;
    extraConfig = {
      init.defaultBranch = "main";
      safe.directory = "/persist/nixos";
    };
  };
}
