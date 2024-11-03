{lib, ...}: {
  # PulseAudio
  hardware = {
    pulseaudio = {
      enable = lib.mkForce true;
      extraConfig = ''
        load-module module-ladspa-sink
        sink_name=binaural
        master=bluez_sink.AA_BB_CC_DD_EE_FF.a2dp_sink
        plugin=bs2b
        label=bs2b
        control=700,4.5
      '';
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
    enable = lib.mkDefault true;
  };
}
