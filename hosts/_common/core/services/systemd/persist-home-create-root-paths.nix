{
  config,
  configVars,
  lib,
  ...
}: {
  systemd.services."persist-home-create-root-paths" = let
    inherit (configVars) persistDir;

    persistentHomesRoot = "${persistDir}";

    listOfCommands =
      lib.mapAttrsToList
      (
        _: user: let
          userHome = lib.escapeShellArg (persistentHomesRoot + user.home);
        in ''
          if [[ ! -d ${userHome} ]]; then
              echo "Persistent home root folder '${userHome}' not found, creating..."
              mkdir -p --mode=${user.homeMode} ${userHome}
              chown -R ${user.name}:${user.group} ${userHome}
          fi
        ''
      )
      (lib.filterAttrs (_: user: user.createHome == true) config.users.users);

    stringOfCommands = lib.concatLines listOfCommands;
  in {
    serviceConfig = {
      StandardError = "journal";
      StandardOutput = "journal";
      Type = "oneshot";
    };
    unitConfig = {
      After = ["persist-home.mount"];
      Description = "Ensure users' home folders exist in the persistent filesystem";
      PartOf = ["local-fs.target"];
    };
    # [Install]
    wantedBy = ["local-fs.target"];
    script = stringOfCommands;
  };
}
