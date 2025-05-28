{lib, ...}: {
  # PulseAudio
  hardware = {
    pulseaudio = {
      enable = lib.mkForce false;
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
    enable = lib.mkForce true;
    extraConfig = {
      pipewire-pulse = {
        "92-low-latency" = {
          context.modules = [
            {
              name = "libpipewire-module-protocol-pulse";
              args = {
                pulse.min.req = "32/48000";
                pulse.default.req = "32/48000";
                pulse.max.req = "32/48000";
                pulse.min.quantum = "32/48000";
                pulse.max.quantum = "32/48000";
              };
            }
          ];
          stream.properties = {
            node.latency = "32/48000";
            resample.quality = 1;
          };
        };
      };
    };
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
    systemWide = false;
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
}
