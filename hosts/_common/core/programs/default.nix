{...}: {
  # Not all programs will be included. Some are included by home.nix.
  imports = [
    ./gnupg
    ./mtr
  ];
}
