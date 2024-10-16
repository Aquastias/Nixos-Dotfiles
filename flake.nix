{
  description = "Aquastias's Nix-Config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
      disko,
      home-manager,
      ...
    }@inputs:
    let
      inherit (self) outputs;
      inherit (nixpkgs) lib;
      system = "x86_64-linux";
      configVars = import ./vars { inherit inputs lib; };
      extraSpecialArgs = {
        inherit inputs;
        inherit outputs;
        inherit configVars;
        inherit nixpkgs;
        inherit system;
      };
      shared-modules = [
        disko.nixosModules.disko
        home-manager.nixosModules.home-manager
        {
          home-manager.extraSpecialArgs = extraSpecialArgs;
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "backup";
        }
      ];
    in
    {
      overlays = import ./overlays { inherit inputs outputs; };

      # Dynamically generate nixosConfigurations for each host
      nixosConfigurations =
        builtins.mapAttrs
          (
            host: _:
            nixpkgs.lib.nixosSystem {
              specialArgs = {
                hostName = host;
              } // extraSpecialArgs;
              modules = shared-modules ++ [ ./hosts/${host}/configuration.nix ];
            }
          )
          (
            builtins.listToAttrs (
              map (host: {
                name = host;
                value = null;
              }) configVars.hosts.names
            )
          );
    };
}
