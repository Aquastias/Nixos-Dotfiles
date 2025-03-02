{pkgs, ...}: {
  systemd.services.fix-persist-home-permissions = {
    description = "Fix /persist/home permissions for each user";
    after = ["local-fs.target"];
    before = ["display-manager.service"]; # If you use a display manager
    serviceConfig = {
      Type = "oneshot";
      ExecStart = ''
        for user in /persist/home/*; do
          if [ -d "$user" ]; then
            username=$(basename "$user")

            if id "$username" >/dev/null 2>&1; then
              ${pkgs.coreutils}/bin/chown -R "$username":users "$user"
            else
              echo "User $username not found, skipping $user"
            fi
          fi
        done
      '';
    };
    wantedBy = ["multi-user.target"];
  };
}
