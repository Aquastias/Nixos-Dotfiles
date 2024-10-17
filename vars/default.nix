{ inputs, lib }:

{
  functions = {
    path = ../functions;
  };
  hosts = {
    common = {
      core = rec {
        mainPathCore = ../hosts/_common/core;
        path =
          let
            absoluteMainPathCore = builtins.path mainPathCore;
          in
          {
            nix = "${absoluteMainPathCore}/nix";
            programs = "${absoluteMainPathCore}/programs";
            services = "${absoluteMainPathCore}/services";
            system = "${absoluteMainPathCore}/system";
          };
      };
      optional = rec {
        mainPathOptional = ../hosts/_common/optional;
        path =
          let
            absoluteMainPathOptional = builtins.path mainPathOptional;
          in
          {
            nix = "${absoluteMainPathOptional}/nix";
            programs = "${absoluteMainPathOptional}/programs";
            services = "${absoluteMainPathOptional}/services";
            system = "${absoluteMainPathOptional}/system";
          };
      };
      disks = ../hosts/_common/disks;
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
