{configVars, ...}: let
  inherit (configVars) disko persistFolder;
  inherit (disko) systemDir;
in {
  system.activationScripts.persistDirs = ''
    mkdir -p ${persistFolder}/${systemDir}/etc/nixos
    mkdir -p ${persistFolder}/${systemDir}/etc/NetworkManager/system-connections
    mkdir -p ${persistFolder}/${systemDir}/etc/ssh
    mkdir -p ${persistFolder}/${systemDir}/var/keys
    mkdir -p ${persistFolder}/${systemDir}/var/log
    mkdir -p ${persistFolder}/${systemDir}/var/lib/colord
    mkdir -p ${persistFolder}/${systemDir}/var/lib/bluetooth
    mkdir -p ${persistFolder}/${systemDir}/var/lib/nixos
    mkdir -p ${persistFolder}/${systemDir}/var/lib/systemd/coredump
  '';
}
