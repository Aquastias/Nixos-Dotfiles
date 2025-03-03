{
  disko.devices = {
    disk = {
      main = {
        device = "/dev/vda";
        type = "disk";
        content = {
          type = "gpt";

          partitions = {
            ESP = {
              size = "512M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = ["umask=0022"]; #0077 for very strict
              };
            };
            swap = {
              size = "4G";
              content = {
                type = "swap";
                resumeDevice = true;
              };
            };
            zfs = {
              size = "100%";
              content = {
                type = "zfs";
                pool = "zroot";
              };
            };
          };
        };
      };
    };
    zpool = {
      zroot = {
        type = "zpool";

        rootFsOptions = {
          # Source:
          # https://wiki.archlinux.org/title/Install_Arch_Linux_on_ZFS
          # https://www.high-availability.com/docs/ZFS-Tuning-Guide/#general-recommendations
          acltype = "posixacl";
          atime = "off";
          compression = "zstd";
          mountpoint = "none";
          xattr = "sa";
        };

        options = {
          # Source:
          # https://wiki.archlinux.org/title/Advanced_Format
          # https://www.high-availability.com/docs/ZFS-Tuning-Guide/#alignment-shift-ashiftn
          ashift = "12";
        };

        datasets = let
          systemDir = "system";
          persistFolder = "/persist";
          systemDatasets = {
            "${systemDir}" = {
              type = "zfs_fs";
              options.mountpoint = "none";
            };
            "${systemDir}/root" = {
              type = "zfs_fs";
              mountpoint = "/";
              options = {
                "com.sun:auto-snapshot" = "false";
                encryption = "aes-256-gcm";
                keyformat = "passphrase";
                keylocation = "prompt";
              };
              postCreateHook = "zfs list -t snapshot -H -o name | grep -E '^zroot/${systemDir}/root@blank$' || zfs snapshot zroot/${systemDir}/root@blank";
            };
            "${systemDir}/home" = {
              type = "zfs_fs";
              mountpoint = "/home";
              # Used by services.zfs.autoSnapshot options.
              options."com.sun:auto-snapshot" = "true";
            };
            "${systemDir}/nix" = {
              type = "zfs_fs";
              mountpoint = "/nix";
              options."com.sun:auto-snapshot" = "false";
            };
            "${systemDir}${persistFolder}" = {
              type = "zfs_fs";
              mountpoint = "${persistFolder}";
              options."com.sun:auto-snapshot" = "false";
            };
          };
        in
          systemDatasets;
      };
    };
  };
}
