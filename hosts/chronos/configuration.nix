# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ configVars, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    "${configVars.hosts.common.disks}/zfs-impermanence-one-nvme.nix"

    "${configVars.hosts.common.core.mainPathCore}/nix.nix"
    "${configVars.hosts.common.core.mainPathCore}/nixpkgs.nix"

    "${configVars.hosts.common.core.mainPathCore}/system"

    "${configVars.hosts.common.core.mainPathCore}/programs/gnupg.nix"
    "${configVars.hosts.common.core.mainPathCore}/programs/mtr.nix"

    "${configVars.hosts.common.core.mainPathCore}/services/gnome.nix"
    "${configVars.hosts.common.core.mainPathCore}/services/libinput.nix"
    "${configVars.hosts.common.core.mainPathCore}/services/openssh.nix"
    "${configVars.hosts.common.core.mainPathCore}/services/printing.nix"
    "${configVars.hosts.common.core.mainPathCore}/services/xserver.nix"

    ../../users/users/aquastias
  ];

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.05"; # Did you read the comment?
}
