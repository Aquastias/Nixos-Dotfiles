{
  description = "Aquastias's Nix-Config";

  inputs = {
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

    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-24.11";
    };

    nixpkgs-unstable = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };

    nur = {
      url = "github:nix-community/NUR";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    my-secrets = {
      url = "git+ssh://git@github.com/Aquastias/Nixos-Secrets.git?ref=main&shallow=1";
      flake = false;
    };
  };

  outputs = {
    arkenfox,
    disko,
    home-manager,
    impermanence,
    my-secrets,
    nixpkgs,
    nur,
    self,
    sops-nix,
    ...
  } @ inputs: let
    configVars = import ./vars {inherit inputs lib;};

    inherit (self) outputs;
    inherit (nixpkgs) lib;
    inherit (configVars) functions system hosts;

    pkgs = import nixpkgs {
      inherit system;

      config.allowUnfree = true;
      overlays = import ./overlays {inherit inputs outputs;};
    };

    extraSpecialArgs = {
      inherit configVars;
      inherit inputs;
      inherit my-secrets;
      inherit nixpkgs;
      inherit nur;
      inherit outputs;
      inherit pkgs;
      inherit system;

      firefoxAddons = pkgs.nur.repos.rycee.firefox-addons;
    };

    shared-modules = host: [
      disko.nixosModules.disko
      home-manager.nixosModules.home-manager
      impermanence.nixosModules.impermanence
      sops-nix.nixosModules.sops
      {
        home-manager = {
          backupFileExtension = "backup";
          extraSpecialArgs = {hostName = host;} // extraSpecialArgs;
          sharedModules = [
            arkenfox.hmModules.default
            sops-nix.homeManagerModules.sops
          ];
          useGlobalPkgs = true;
          useUserPackages = true;
        };
      }
    ];

    host-utils = import "${functions.path}/host-utils.nix" {
      inherit extraSpecialArgs;
      inherit lib;
      inherit shared-modules;

      hostsPath = hosts.path;
    };
  in {
    nixosConfigurations = host-utils.mkHostConfigs (host-utils.readHosts hosts.path);
  };
}
