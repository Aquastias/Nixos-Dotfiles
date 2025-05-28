[
  {
    name = "wikipedia";
    tags = ["wiki"];
    keyword = "wiki";
    url = "https://en.wikipedia.org/wiki/Special:Search?search=%s&go=Go";
  }

  {
    name = "Nix";
    toolbar = true;
    bookmarks = [
      {
        name = "Nix sites";
        bookmarks = [
          {
            name = "NixOS";
            bookmarks = [
              {
                name = "NixOS Homepage";
                tags = ["nix"];
                url = "https://nixos.org/";
              }
              {
                name = "NixOS Wiki";
                tags = ["nix" "wiki"];
                url = "https://wiki.nixos.org/";
              }
              {
                name = "NixOS Dev";
                tags = ["nix"];
                url = "https://nix.dev/index.html";
              }
              {
                name = "NixOS packages";
                tags = ["nix" "search"];
                url = "https://search.nixos.org/packages";
              }
            ];
          }
          {
            name = "Home Manager";
            bookmarks = [
              {
                name = "Home Manager options";
                tags = ["home-manager" "nix" "wiki"];
                url = "https://nix-community.github.io/home-manager/options.xhtml";
              }
              {
                name = "Home Manager search";
                tags = ["home-manager" "nix" "search"];
                url = "https://home-manager-options.extranix.com/";
              }
            ];
          }
        ];
      }
    ];
  }
]
