# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    ../_common/disks/disk-config-laptop.nix
    ../_common/core/nix.nix
    ../_common/core/nixpkgs.nix
    ../_common/core/boot.nix
    ../_common/core/locale.nix
    ../_common/core/networking.nix
    ../_common/core/fonts.nix
    ../_common/core/audio.nix

    ../_common/core/programs/gnupg.nix
    ../_common/core/programs/mtr.nix

    ../_common/core/services/gnome.nix
    ../_common/core/services/libinput.nix
    ../_common/core/services/openssh.nix
    ../_common/core/services/printing.nix
    ../_common/core/services/xserver.nix
  ];

  users.users.aquastias = {
    isNormalUser = true;
    extraGroups = [
      "wheel" # Enable ‘sudo’ for the user.
      "gpg" # For GnuPG
      "scanner" # To be able to see scanner devices
    ];
    packages = builtins.attrValues { inherit (pkgs) firefox tree; };
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages =
    let
      packages = pkgs;
      gnome = pkgs.gnome;
    in
    builtins.attrValues {
      home-manager = packages.home-manager;
      vim = packages.vim;
      wget = packages.wget;
      curl = packages.curl;
      nil = packages.nil;
      nixfmt-rfc-style = packages.nixfmt-rfc-style;
      seahorse = gnome.seahorse;
    };
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

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
