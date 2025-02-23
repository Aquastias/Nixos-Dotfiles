{lib, ...}: {
  boot = {
    bootspec = {
      enable = true;
    };
    initrd = {
      postDeviceCommands = lib.mkAfter ''
        # Create snapshot of the root dataset
        timestamp=$(date "+%Y-%m-%-d_%H:%M:%S")
        zfs snapshot zroot/local/root@"$timestamp"

        # Delete snapshots older than 30 days
        zfs list -t snapshot -H -o name zroot/local/root | while read -r snapshot; do
          snapshot_time=$(echo "$snapshot" | sed 's/zroot\/local\/root@//')
          snapshot_epoch=$(date -d "$snapshot_time" +%s)
          current_epoch=$(date +%s)

          if [[ $((current_epoch - snapshot_epoch)) -gt $((30 * 24 * 60 * 60)) ]]; then
            zfs destroy "$snapshot"
          fi
        done
      '';
    };
    loader = {
      efi = {
        canTouchEfiVariables = true;
      };
      systemd-boot = {
        enable = lib.mkForce true;
      };
    };
    zfs = {
      devNodes = "/dev/disk/by-partuuid";
    };
  };
}
