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

    hostDir = ./hosts;
    hostConfFiles = builtins.find hostDir (path: type: path == "${hostDir}/${type}/configuration.nix");
    hostNames = builtins.map (path: builtins.head (builtins.tail (builtins.splitPath path))) hostConfFiles;
  in {
    nixosConfigurations = lib.genAttrs hostNames (hostName:
      nixpkgs.lib.nixosSystem {
        specialArgs = {hostName = hostName;} // extraSpecialArgs;
        modules = shared-modules hostName ++ ["${hostDir}/${hostName}/configuration.nix"];
      });
  };
}
