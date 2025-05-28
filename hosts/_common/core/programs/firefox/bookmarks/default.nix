{lib, ...}: {
  programs.firefox = {
    policies = {
      ManagedBookmarks = lib.importJSON ./managed-bookmarks.json;
    };

    profiles = {
      default = {
        bookmarks = import ./default-bookmarks.nix;
      };
    };
  };
}
