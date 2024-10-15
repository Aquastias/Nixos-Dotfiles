{ lib, specialArgs, ... }:

let
  # Function to generate a hostId of a specific length (8 characters).
  generateHostId = import ../../../functions/generateHostId.nix;
in
{
  networking = {
    firewall = {
      enable = true;
      allowPing = true;
      allowedTCPPorts = [
        22 # SSH
        80 # HTTP
        443 # HTTPS
      ];
      allowedUDPPorts = [
        53 # DNS
      ];
    };
    hostId = lib.mkDefault (generateHostId {
      hostName = specialArgs.host;
    });
    hostName = lib.mkDefault specialArgs.host;
    networkmanager = {
      enable = true;
    };
    wireless = {
      # Enables wireless support via wpa_supplicant.
      enable = false;
    };
  };
}
