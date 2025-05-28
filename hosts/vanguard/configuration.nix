# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
{configVars, ...}: let
  inherit (configVars) hosts entities version;
  inherit (hosts.common.core) nix programs services system;

  users = import ./users.nix;
in {
  imports =
    [
      ./hardware
      ./disko-config.nix
      ./fileSystems.nix

      "${nix.path}"
      "${programs.path}"
      "${services.path}"
      "${system.path}"
    ]
    ++ builtins.map (user: "${entities.users.path}/${user}") users;

  # users.users = {
  #   openssh = {
  #     authorizedKeys = {
  #       keys = [
  #         (builtins.readFile ../../entities/users/aquastias/keys/id_aquastias.pub)
  #       ];
  #     };
  #   };
  # };

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
  system.stateVersion = "${version}"; # Did you read the comment?
}
