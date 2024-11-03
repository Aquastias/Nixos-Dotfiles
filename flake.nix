{
  description = "Aquastias's Nix-Config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";

    arkenfox = {
      url = "github:dwarfmaster/arkenfox-nixos";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    disko,
    home-manager,
    arkenfox,
    nur,
    lanzaboote,
    sops-nix,
    ...
  } @ inputs: let
    inherit (self) outputs;
    inherit (nixpkgs) lib;

    pkgs = import inputs.nixpkgs {
      inherit system;

      config.allowUnfree = true;
      overlays = import ./overlays {inherit inputs outputs;};
    };

    system = "x86_64-linux";
    configVars = import ./vars {inherit inputs lib;};
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
      lanzaboote.nixosModules.lanzaboote
      sops-nix.nixosModules.sops
      home-manager.nixosModules.home-manager
      {
        home-manager.extraSpecialArgs =
          {
            hostName = host;
          }
          // extraSpecialArgs;
        home-manager.sharedModules = [arkenfox.hmModules.default];
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.backupFileExtension = "backup";
      }
    ];
  in {
    # Dynamically generate nixosConfigurations for each host
    nixosConfigurations =
      builtins.mapAttrs
      (
        host: _:
          nixpkgs.lib.nixosSystem {
            specialArgs =
              {
                hostName = host;
              }
              // extraSpecialArgs;
            modules = shared-modules host ++ [./hosts/${host}/configuration.nix];
          }
      )
      (
        builtins.listToAttrs (
          map (host: {
            name = host;
            value = null;
          })
          configVars.hosts.names
        )
      );
  };
}
