{...}: {
  # Only primitive values, nothing dynamic.

  disko = {
    systemDir = "system";
  };
  entities = {
    home = {
      path = ../entities/home.nix;
    };
    users = {
      path = ../entities/users;
    };
  };
  flake = {
    path = ../flake.nix;
  };
  functions = {
    path = ../functions;
  };
  hosts = {
    path = ../hosts;
    common = {
      core = {
        path = ../hosts/_common/core;
        nix.path = ../hosts/_common/core/nix;
        programs.path = ../hosts/_common/core/programs;
        services.path = ../hosts/_common/core/services;
        system.path = ../hosts/_common/core/system;
      };
      optional = {
        path = ../hosts/_common/optional;
        nix.path = ../hosts/_common/optional/nix;
        programs.path = ../hosts/_common/optional/programs;
        services.path = ../hosts/_common/optional/services;
        system.path = ../hosts/_common/optional/system;
      };
    };
  };
  persistFolder = "/persist";
  secrets = {
    path = ../secrets.yaml;
  };
  system = "x86_64-linux";
  version = "24.11";
}
