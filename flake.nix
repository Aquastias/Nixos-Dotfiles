{
  description = "Aquastias's Nix-Config";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    oxalica-nil = {
      url = "github:oxalica/nil";
      inputs.nixpks.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      inherit (self) outputs;
      forAllSystems = nixpkgs.lib.genAttrs [
	"x86_64-linux"
      ];
      inherit (nixpkgs) lib;
      host = "chronos";
      pkgs = nixpkgs.legacyPackages."x86_64-linux";
      configVars = import ./vars { inherit inputs lib; };
      specialArgs = {
	inherit inputs;
	inherit outputs;
	inherit configVars;
	inherit nixpkgs;
      };
    in {
      # Custom modifications/overrides to upstream packages.
      overlays = import ./overlays { inherit inputs outputs; };

      nixosConfigurations = {
        "${host}" = nixpkgs.lib.nixosSystem {
	  inherit specialArgs; 
          modules = [
	    ./hosts/${host}/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.extraSpecialArgs = specialArgs;
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "backup";
              home-manager.users.${configVars.username} = import ./hosts/${host}/home.nix;
            }
          ];
	};
      };
    };
}
