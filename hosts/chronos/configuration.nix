# Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    # Disko layout
    ../_common/disks/one-nvme.nix

    # Core programs, services and system related stuff
    ../_common/core
  ];
}
