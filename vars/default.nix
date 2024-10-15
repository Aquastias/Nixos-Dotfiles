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
            absoluteMainPath = builtins.path mainPathCore;
          in
          {
            nix = "${absoluteMainPath}/nix";
            programs = "${absoluteMainPath}/programs";
            services = "${absoluteMainPath}/services";
            system = "${absoluteMainPath}/system";
          };
      };
      optional = rec {
        mainPathOptional = ../hosts/_common/optional;
        path =
          let
            absoluteMainPath = builtins.path mainPathOptional;
          in
          {
            nix = "${absoluteMainPath}/nix";
            programs = "${absoluteMainPath}/programs";
            services = "${absoluteMainPath}/services";
            system = "${absoluteMainPath}/system";
          };
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
  };
}
