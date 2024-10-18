{ pkgs, specialArgs, ... }:

let
  inherit (specialArgs) firefoxAddons;
in
{
  programs.firefox = {
    enable = true;
    languagePacks = [ "en-US" ];
    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
      DisablePocket = true;
      DisableFirefoxAccounts = true;
      DisableAccounts = true;
      DisableFirefoxScreenshots = true;
      OverrideFirstRunPage = "";
      OverridePostUpdatePage = "";
      DontCheckDefaultBrowser = true;
      DisplayBookmarksToolbar = "never"; # alternatives: "always" or "newtab"
      DisplayMenuBar = "default-off"; # alternatives: "always", "never" or "default-on"
      SearchBar = "unified"; # alternative: "separate" w
    };
    profiles = {
      default = {
        id = 0;
        name = "default";
        isDefault = true;
        settings = {
          "browser.startup.homepage" = "https://searx.work";
          "browser.search.defaultenginename" = "Searx";
          "browser.search.order.1" = "Searx";
        };
        search = {
          force = true;
          default = "Searx";
          order = [
            "Searx"
            "DuckDuckGo"
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
              icon = "''${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = [ "@np" ];
            };
            "NixOS Wiki" = {
              urls = [ { template = "https://nixos.wiki/index.php?search={searchTerms}"; } ];
              iconUpdateURL = "https://nixos.wiki/favicon.png";
              updateInterval = 24 * 60 * 60 * 1000; # Every day
              definedAliases = [ "@nw" ];
            };
            "Searx" = {
              urls = [ { template = "https://searx.work/?q={searchTerms}"; } ];
              iconUpdateURL = "https://nixos.wiki/favicon.png";
              updateInterval = 24 * 60 * 60 * 1000; # Every day
              definedAliases = [ "@searx" ];
            };
            "Google".metaData.alias = "@g"; # builtin engines only support specifying one additional alias
          };
        };
        extensions =
          let
            inherit firefoxAddons;
          in
          builtins.filter (addon: addon != null) (
            builtins.attrValues {
              betterTTV = firefoxAddons.betterttv;
              bitWarden = firefoxAddons.bitwarden;
              canvasBlocker = firefoxAddons.canvasblocker;
              darkReader = firefoxAddons.darkreader;
              faceBookContainer = firefoxAddons.facebook-container;
              hoppscotch = firefoxAddons.hoppscotch;
              iDontCareAboutCookies = firefoxAddons.i-dont-care-about-cookies;
              linkCleaner = firefoxAddons.link-cleaner;
              multiAccountContainers = firefoxAddons.multi-account-containers;
              privacyBadger = firefoxAddons.privacy-badger;
              returnYouTubeDislikes = firefoxAddons.return-youtube-dislikes;
              tabliss = firefoxAddons.tabliss;
              treeStyleTab = firefoxAddons.tree-style-tab;
              uBlockOrigin = firefoxAddons.ublock-origin;
              unPaywall = firefoxAddons.unpaywall;
              vimium = firefoxAddons.vimium;
              youTubeNonStop = firefoxAddons.youtube-nonstop;
            }
          );
      };
    };
  };
}
