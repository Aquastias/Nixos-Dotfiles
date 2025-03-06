{
  userName,
  userEmail,
  persistFolder,
  ...
}: {
  home = {
    username = userName;
    homeDirectory = "/home/${userName}";

    persistence."${persistFolder}/home/${userName}" = {
      directories = [
        "Desktop"
        "Documents"
        "Downloads"
        "Music"
        "Pictures"
        "Public"
        "Templates"
        "Videos"
        ".gnupg"
        ".ssh"
        ".mozilla"
        ".vscode-oss"
        ".local/share/keyrings"
        ".local/share/direnv"
        {
          directory = ".local/share/Steam";
          method = "symlink";
        }
      ];
      files = [
        ".screenrc"
      ];
      allowOther = true;
    };
  };

  programs = {
    git = {
      inherit userEmail userName;
    };

    vscode = {
      enable = true;
    };
  };
}
