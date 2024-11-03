{lib, ...}: {
  # PulseAudio
  hardware = {
    pulseaudio = {
      enable = lib.mkForce true;
      support32Bit = true;
    };
  };

  # Pipewire
  security.rtkit.enable = true;
  services.pipewire = {
    enable = lib.mkForce false;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    jack = {
      enable = true;
    };
    pulse = {
      enable = true;
    };
    socketActivation = true;
    systemWide = true;
    wireplumber = {
      enable = true;
      extraConfig = {
        bluetoothEnhancements = {
          "monitor.bluez.properties" = {
            "bluez5.enable-sbc-xq" = true;
            "bluez5.enable-msbc" = true;
            "bluez5.enable-hw-volume" = true;
            "bluez5.roles" = ["hsp_hs" "hsp_ag" "hfp_hf" "hfp_ag"];
          };
        };
      };
    };
  };

  # ALSA
  sound = {
    enable = true;
  };
}
