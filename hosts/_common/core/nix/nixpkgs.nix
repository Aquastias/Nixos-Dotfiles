{...}: {
  nixpkgs = {
    config = {
      allowUnfree = true;
      pulseaudio = true;
    };
  };
}
