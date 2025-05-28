{...}: {
  services = {
    gnome = {
      gnome-keyring = {
        enable = true; # For apps that use gnome keyring e.g. VSCode
      };
    };
  };
}
