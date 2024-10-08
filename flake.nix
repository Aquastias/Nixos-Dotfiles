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
      host = if builtins.hasAttr "host" inputs then inputs.host else configVars.defaultHost;
      configVars = import ./vars { inherit inputs lib; };
      specialArgs = {
        inherit inputs;
        inherit outputs;
        inherit host;
        inherit configVars;
        inherit nixpkgs;
      };
    in
    {
      overlays = import ./overlays { inherit inputs outputs; };

      nixosConfigurations = {
        "${host}" = nixpkgs.lib.nixosSystem {
          inherit specialArgs;
          system = "x86_64-linux";
          modules = [
            ./hosts/${host}/configuration.nix
            disko.nixosModules.disko
            home-manager.nixosModules.home-manager
            {
              home-manager.extraSpecialArgs = specialArgs;
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "backup";
              home-manager.users.${configVars.userName} = import ./hosts/${host}/home.nix;
            }
          ];
        };
      };
    };
}
