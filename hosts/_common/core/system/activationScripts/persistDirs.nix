{configVars, ...}: let
  inherit (configVars) disko persistDir;
  inherit (disko) systemDir;
in {
  system.activationScripts.persistDirs = ''
    mkdir -p ${persistDir}/${systemDir}/etc/nixos
    mkdir -p ${persistDir}/${systemDir}/etc/NetworkManager/system-connections
    mkdir -p ${persistDir}/${systemDir}/etc/ssh
    mkdir -p ${persistDir}/${systemDir}/var/keys
    mkdir -p ${persistDir}/${systemDir}/var/log
    mkdir -p ${persistDir}/${systemDir}/var/lib/colord
    mkdir -p ${persistDir}/${systemDir}/var/lib/bluetooth
    mkdir -p ${persistDir}/${systemDir}/var/lib/nixos
    mkdir -p ${persistDir}/${systemDir}/var/lib/systemd/coredump
  '';
}
