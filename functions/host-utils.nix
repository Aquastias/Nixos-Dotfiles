{
  lib,
  extraSpecialArgs,
  shared-modules,
  hostsPath,
}: let
  # Handle a given host config
  mkHost = host: {
    ${host} = let
      func = lib.nixosSystem;
      systemFunc = func;
    in
      systemFunc {
        specialArgs = {hostName = host;} // extraSpecialArgs;
        modules = shared-modules host ++ ["${hostsPath}/${host}/configuration.nix"];
      };
  };
  # Invoke mkHost for each host config that is declared
  mkHostConfigs = hosts: lib.foldl (acc: set: acc // set) {} (lib.map (host: mkHost host) hosts);
  # Return the hosts declared in the given directory
  readHosts = folder: lib.attrNames (builtins.readDir "${folder}");
in {
  inherit mkHost;
  inherit mkHostConfigs;
  inherit readHosts;
}
