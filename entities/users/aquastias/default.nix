{
  configVars,
  inputs,
  ...
}: let
  inherit (configVars) persistFolder entities;
  userName = "aquastias";
  userEmail = "alexandrumlakar@gmail.com";
in {
  users.users."${userName}" = {
    initialPassword = "password";
    isNormalUser = true;
    description = "Aquastias";
    extraGroups = [
      "audio"
      "gpg" # For GnuPG
      "scanner" # To be able to see scanner devices
      "wheel" # Enable ‘sudo’ for the user.
    ];
  };

  home-manager = {
    users."${userName}" = {...}: {
      imports = [
        entities.home.path
        inputs.impermanence.homeManagerModules.impermanence

        ./config.nix
      ];

      extraSpecialArgs = {
        inherit userName userEmail persistFolder;
      };
    };
  };
}
