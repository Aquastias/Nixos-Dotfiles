{configVars, ...}: {
  sops = {
    age = {
      keyFile = "/home/aquastias/.config/sops/age/keys.txt";
    };
    defaultSopsFile = "${configVars.secrets.path}/secrets.yaml";
    defaultSopsFormat = "yaml";
    secrets = {
      example-key = {};
      "myservice/my_subdir/my_secret" = {
        owner = "aquastias";
      };
    };
  };
}
