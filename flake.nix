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
      shared-modules = [
        disko.nixosModules.disko
        home-manager.nixosModules.home-manager
        {
          home-manager.extraSpecialArgs = specialArgs;
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "backup";
        }
      ];
      specialArgs = {
        inherit inputs;
        inherit outputs;
        inherit configVars;
        inherit nixpkgs;
      };
    in
    {
      nixosConfigurations = {
        chronos = nixpkgs.lib.nixosSystem {
          inherit specialArgs system;
          modules = shared-modules ++ [ ./hosts/chronos/configuration.nix ];
        };
      };
      # Dynamically generate nixosConfigurations for each host
      # nixosConfigurations =
      #   builtins.mapAttrs
      #     (
      #       host: _:
      #       nixpkgs.lib.nixosSystem {
      #         inherit specialArgs system;
      #         modules = shared-modules ++ [ ./hosts/${host}/configuration.nix ];
      #       }
      #     )
      #     (
      #       builtins.listToAttrs (
      #         map (host: {
      #           name = host;
      #           value = null;
      #         }) hostNames
      #       )
      #     );

      overlays = import ./overlays { inherit inputs outputs; };
      packages."${system}".default = true;
    };
}
