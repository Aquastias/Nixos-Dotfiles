{ lib, inputs, ... }:

{
  networking = {
    hostId = lib.mkDefault "711fbabc";
    hostName = lib.mkDefault inputs.host;
    networkmanager = {
      enable = true;
    };
    wireless = {
      # Enables wireless support via wpa_supplicant.
      enable = false;
    };
  };
}
