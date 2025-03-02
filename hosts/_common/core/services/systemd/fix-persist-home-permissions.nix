{pkgs, ...}: {
  systemd.services.fix-persist-home-permissions = {
    description = "Fix /persist/home permissions for each user";
    after = ["local-fs.target"];
    before = ["display-manager.service"];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = ''
        ${pkgs.findutils}/bin/find /persist/home -maxdepth 1 -type d -exec sh -c '
          username=$(basename "$1")

          if id "$username" >/dev/null 2>&1; then
            ${pkgs.coreutils}/bin/chown -R "$username":users "$1"
          else
            echo "User $username not found, skipping $1"
          fi
        ' sh {} \;
      '';
    };
    wantedBy = ["multi-user.target"];
  };
}
