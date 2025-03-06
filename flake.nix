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
        ];
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.backupFileExtension = "backup";
      }
    ];

    #
    # ========= Host Config Functions =========
    #
    # Handle a given host config
    mkHost = host: {
      ${host} = let
        func = lib.nixosSystem;
        systemFunc = func;
      in
        systemFunc {
          specialArgs = {hostName = host;} // extraSpecialArgs;
          modules = shared-modules host ++ [./hosts/${host}/configuration.nix];
        };
    };
    # Invoke mkHost for each host config that is declared
    mkHostConfigs = hosts: lib.foldl (acc: set: acc // set) {} (lib.map (host: mkHost host) hosts);
    # Return the hosts declared in the given directory
    readHosts = folder: lib.attrNames (builtins.readDir ./${folder});
  in {
    nixosConfigurations = mkHostConfigs (readHosts "hosts");
  };
}
