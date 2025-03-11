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

    sops-nix = {
      url = "github:Mic92/sops-nix";
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
    sops-nix,
    ...
  } @ inputs: let
    inherit (self) outputs;
    inherit (nixpkgs) lib;

    configVars = import ./vars {inherit inputs lib;};
    inherit (configVars) functions system hosts;

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
      home-manager.nixosModules.home-manager
      impermanence.nixosModules.impermanence
      sops-nix.nixosModules.sops
      {
        home-manager.extraSpecialArgs =
          {
            hostName = host;
          }
          // extraSpecialArgs;
        home-manager.sharedModules = [
          arkenfox.hmModules.default
          sops-nix.homeManagerModules.sops
        ];
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.backupFileExtension = "backup";
      }
    ];

    host-utils = import "${functions.path}/host-utils.nix" {
      inherit lib;
      inherit extraSpecialArgs;
      inherit shared-modules;

      hostsPath = hosts.path;
    };
  in {
    nixosConfigurations = host-utils.mkHostConfigs (host-utils.readHosts hosts.path);
  };
}
