{...}: {
  # PulseAudio
  hardware = {
    pulseaudio = {
      enable = false;
    };
  };

  # Pipewire
  services.pipewire = {
    alsa = {
      enable = true;
      support32Bit = true;
    };
    enable = true;
    jack = {
      enable = true;
    };
    pulse = {
      enable = true;
    };
    systemWide = true;
    wireplumber = {
      enable = true;
    };
  };
}
