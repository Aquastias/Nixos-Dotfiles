{ inputs, lib }:

{
  # Only primitive values, nothing dynamic.
  functions = {
    path = ../functions;
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
      disks = {
        path = ../hosts/_common/disks;
      };
    };
    names = [
      "chronos"
      "eterniox"
    ];
  };
  persistFolder = "/persist";
  users = {
    home = {
      path = ../users/home.nix;
    };
    users = {
      path = ../users/users;
    };
  };
}
