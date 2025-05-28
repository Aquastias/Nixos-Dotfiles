{pkgs, ...}: let
  search = {
    force = true;
    default = "Brave Search";
    order = [
      "Searx"
      "DuckDuckGo"
      "Youtube"
      "NixOS Options"
      "Nix Packages"
      "GitHub"
      "Brave Search"
      "Google"
    ];
    engines = {
      "Nix Packages" = {
        urls = [
          {
            template = "https://search.nixos.org/packages";
            params = [
              {
                name = "type";
                value = "packages";
              }
              {
                name = "query";
                value = "{searchTerms}";
              }
            ];
          }
        ];
        icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
        definedAliases = ["@np"];
      };
      "NixOS Wiki" = {
        urls = [{template = "https://nixos.wiki/index.php?search={searchTerms}";}];
        iconUpdateURL = "https://nixos.wiki/favicon.png";
        updateInterval = 24 * 60 * 60 * 1000;
        definedAliases = ["@nw"];
      };
      "GitHub" = {
        iconUpdateURL = "https://github.com/favicon.ico";
        updateInterval = 24 * 60 * 60 * 1000;
        definedAliases = ["@gh"];
        urls = [
          {
            template = "https://github.com/search";
            params = [
              {
                name = "q";
                value = "{searchTerms}";
              }
            ];
          }
        ];
      };
      "Home Manager" = {
        icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
        definedAliases = ["@hm"];
        url = [
          {
            template = "https://mipmip.github.io/home-manager-option-search/";
            params = [
              {
                name = "query";
                value = "{searchTerms}";
              }
            ];
          }
        ];
      };
      "Searx" = {
        urls = [{template = "https://search.hbubli.cc/?q={searchTerms}";}];
        iconUpdateURL = "https://nixos.wiki/favicon.png";
        updateInterval = 24 * 60 * 60 * 1000;
        definedAliases = ["@searx"];
      };
      "YouTube" = {
        iconUpdateURL = "https://youtube.com/favicon.ico";
        updateInterval = 24 * 60 * 60 * 1000;
        definedAliases = ["@yt"];
        urls = [
          {
            template = "https://www.youtube.com/results";
            params = [
              {
                name = "search_query";
                value = "{searchTerms}";
              }
            ];
          }
        ];
      };
      "Brave Search" = {
        urls = [{template = "https://search.brave.com/search?q={searchTerms}";}];
        iconUpdateURL = "https://brave.com/static-assets/images/brave-favicon.png";
        updateInterval = 24 * 60 * 60 * 1000;
        definedAliases = ["@b"];
      };
      "Google".metaData.alias = "@g"; # Builtin engines only support specifying one additional alias
      "Wikipedia (en)".metaData.alias = "@wiki";
      "Amazon.com".metaData.hidden = true;
      "Bing".metaData.hidden = true;
      "eBay".metaData.hidden = true;
    };
  };
in {
  programs.firefox.profiles.default.search = search;
}
