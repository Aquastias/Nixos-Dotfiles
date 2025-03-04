{
  description = "Aquastias's Nix-Config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    nur.url = "github:nix-community/NUR";

    arkenfox = {
      url = "github:dwarfmaster/arkenfox-nixos";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence = {
      url = "github:nix-community/impermanence";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    arkenfox,
    nur,
    disko,
    impermanence,
    ...
  } @ inputs: let
    inherit (self) outputs;
    inherit (nixpkgs) lib;

    configVars = import ./vars {inherit inputs lib;};
    system = "${configVars.system}";

    pkgs = import nixpkgs {
      inherit system;

      config.allowUnfree = true;
      overlays = import ./overlays {inherit inputs outputs;};
    };

    extraSpecialArgs = {
      inherit inputs;
      inherit outputs;
      inherit configVars;
      inherit nixpkgs;
      inherit system;
      inherit pkgs;
      inherit nur;

      firefoxAddons = pkgs.nur.repos.rycee.firefox-addons;
    };

    shared-modules = host: [
      disko.nixosModules.disko
      impermanence.nixosModules.impermanence
      home-manager.nixosModules.home-manager
      {
        home-manager.extraSpecialArgs =
          {
            hostName = host;
          }
          // extraSpecialArgs;
        home-manager.sharedModules = [
          arkenfox.hmModules.default
          impermanence.homeManagerModules.default
        ];
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.backupFileExtension = "backup";
      }
    ];
  in {
    nixosConfigurations = lib.genAttrs configVars.hosts (host:
      nixpkgs.lib.nixosSystem {
        specialArgs =
          {
            hostName = host;
          }
          // extraSpecialArgs;
        modules = shared-modules host ++ [./hosts/${host}/configuration.nix];
      });
  };
}
