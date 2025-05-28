{...}: {
  services = {
    xserver = {
      desktopManager = {
        gnome = {
          enable = true; # Enable the GNOME Desktop Environment.
        };
      };
      displayManager = {
        gdm = {
          enable = true;
        };
      };
      enable = true; # Enable the X11 windowing system.
    };
  };
}
