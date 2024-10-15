{ lib, configVars, ... }:

let
  functions = import [ configVars.functions.path ];
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
    # hostId = lib.mkDefault (functions.generateHostId { hostName = "chronos"; });
    hostId = builtins.substring 0 8 (builtins.toString (builtins.hashString "sha256" "chronos"));
    hostName = lib.mkDefault "chronos";
    networkmanager = {
      enable = true;
    };
    wireless = {
      # Enables wireless support via wpa_supplicant.
      enable = false;
    };
  };
}
