{...}: {
  users = {
    # Required for password to be set via sops during system activation
    mutableUsers = false;
  };
}
