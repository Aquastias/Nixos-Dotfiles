{inputs, ...}:
with inputs; let
  # When applied, the unstable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.unstable'
  unstable-packages = final: _prev: {
    unstable = import nixpkgs-unstable {
      system = final.system;
      config.allowUnfree = true;
    };
  };
in [
  unstable-packages
  inputs.arkenfox.overlays.default
  nur.overlay
]
