{...}: {
  # Only primitive values, nothing dynamic.
  flake = {
    path = ../flake.nix;
  };
  functions = {
    path = ../functions;
  };
  entities = {
    home = {
      path = ../entities/home.nix;
    };
    users = {
      path = ../entities/users;
    };
  };
  hosts = {
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
    names = [
      "chronos"
      "eterniox"
      "vanguard"
    ];
  };
  persistFolder = "/persist";
}
