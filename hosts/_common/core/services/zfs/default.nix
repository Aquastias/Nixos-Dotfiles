{...}: {
  services = {
    zfs = {
      autoScrub = {
        enable = true;
      };
      autoSnapshot = {
        enable = true;
        hourly = 24; # Retain 24 hourly snapshots
        daily = 7; # Retain 7 daily snapshots
        weekly = 4; # Retain 4 weekly snapshots
        monthly = 6; # Retain 6 monthly snapshots
      };
    };
  };
}
