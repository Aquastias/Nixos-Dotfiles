{
  lib,
  specialArgs,
  configVars,
  ...
}: let
  generateHostId = import "${configVars.functions.path}/generateHostId.nix";
in {
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
      hostName = specialArgs.hostName;
    });
    hostName = lib.mkDefault specialArgs.hostName;
    networkmanager = {
      enable = true;
    };
    wireless = {
      # Enables wireless support via wpa_supplicant.
      enable = false;
    };
  };
}
