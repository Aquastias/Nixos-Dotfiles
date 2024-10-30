{
  specialArgs,
  configVars,
  ...
}: let
  inherit (specialArgs) firefoxAddons;

  toJSONFieldConversion = import "${configVars.functions.path}/toJSONFieldConversion.nix";

  config = {
    "app.normandy.enabled" = false;
    "app.normandy.migrationsApplied" = 12;
    "app.shield.optoutstudies.enabled" = false;
    "accessibility.typeaheadfind.enablesound" = false;
    "beacon.enabled" = false;
    "browser.aboutConfig.showWarning" = false;
    "browser.aboutwelcome.enabled" = false;
    "browser.compactmode.show" = true;
    "browser.contentblocking.report.lockwise.enabled" = false;
    "browser.ctrlTab.sortByRecentlyUsed" = false;
    "browser.download.useDownloadDir" = false;
    "browser.eme.ui.enabled" = false;
    "browser.ml.chat.enabled" = false;
    "browser.ml.chat.sidebar" = false;
    "browser.newtabpage.activity-stream.showSponsored" = false;
    "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
    "browser.ping-centre.telemetry" = false;
    "browser.policies.applied" = true;
    "browser.search.defaultenginename" = "Brave Search";
    "browser.search.order.1" = "Brave Search";
    "browser.startup.homepage" = "https://search.brave.com/";
    "browser.startup.page" = 3; # Resume previous session on startup
    "browser.send_pings" = false;
    "browser.tabs.crashReporting.sendReport" = false;
    "browser.translations.neverTranslateLanguages" = "ro";
    "browser.uiCustomization.state" = {
      placements = {
        "widget-overflow-fixed-list" = [];
        "unified-extensions-area" = [
          "canvasblocker_kkapsner_de-browser-action"
          "addon_darkreader_org-browser-action"
          "_f209234a-76f0-4735-9920-eb62507a54cd_-browser-action"
          "_74145f27-f039-47ce-a470-a662b129930a_-browser-action"
          "postwoman-firefox_postwoman_io-browser-action"
          "_0d7cafdd-501c-49ca-8ebb-e3341caaa55e_-browser-action"
          "_contain-facebook-browser-action"
          "jid1-kkzogwgsw3ao4q_jetpack-browser-action"
          "_762f9885-5a13-4abd-9c77-433dcd38b8fd_-browser-action"
          "_3579f63b-d8ee-424f-bbb6-6d0ce3285e6a_-browser-action"
          "1b2383b324c8520974ee097e46301d5ca4e076de387c02886f1c6b1503671586_pokeinthe_io-browser-action"
          "webpconverter_hilberteikelboom_nl-browser-action"
          "_react-devtools-browser-action"
          "_50864413-c4c8-43b0-80b8-982c4a368ac9_-browser-action"
        ];
        "nav-bar" = [
          "back-button"
          "forward-button"
          "stop-reload-button"
          "home-button"
          "privatebrowsing-button"
          "zoom-controls"
          "customizableui-special-spring1"
          "urlbar-container"
          "customizableui-special-spring2"
          "save-to-pocket-button"
          "developer-button"
          "downloads-button"
          "fxa-toolbar-menu-button"
          "library-button"
          "unified-extensions-button"
          "_testpilot-containers-browser-action"
          "treestyletab_piro_sakura_ne_jp-browser-action"
          "ublock0_raymondhill_net-browser-action"
          "umatrix_raymondhill_net-browser-action"
          "_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action"
          "sponsorblocker_ajay_app-browser-action"
        ];
        "toolbar-menubar" = [
          "menubar-items"
        ];
        "TabsToolbar" = [
          "firefox-view-button"
          "tabbrowser-tabs"
          "new-tab-button"
          "alltabs-button"
          "_c607c8df-14a7-4f28-894f-29e8722976af_-browser-action"
        ];
        "PersonalToolbar" = [
          "personal-bookmarks"
        ];
      };

      seen = [
        "developer-button"
        "sponsorblocker_ajay_app-browser-action"
        "addon_darkreader_org-browser-action"
        "umatrix_raymondhill_net-browser-action"
        "_f209234a-76f0-4735-9920-eb62507a54cd_-browser-action"
        "_74145f27-f039-47ce-a470-a662b129930a_-browser-action"
        "postwoman-firefox_postwoman_io-browser-action"
        "treestyletab_piro_sakura_ne_jp-browser-action"
        "_0d7cafdd-501c-49ca-8ebb-e3341caaa55e_-browser-action"
        "canvasblocker_kkapsner_de-browser-action"
        "_contain-facebook-browser-action"
        "jid1-kkzogwgsw3ao4q_jetpack-browser-action"
        "ublock0_raymondhill_net-browser-action"
        "_762f9885-5a13-4abd-9c77-433dcd38b8fd_-browser-action"
        "_testpilot-containers-browser-action"
        "_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action"
        "_3579f63b-d8ee-424f-bbb6-6d0ce3285e6a_-browser-action"
        "1b2383b324c8520974ee097e46301d5ca4e076de387c02886f1c6b1503671586_pokeinthe_io-browser-action"
        "webpconverter_hilberteikelboom_nl-browser-action"
        "_react-devtools-browser-action"
        "_c607c8df-14a7-4f28-894f-29e8722976af_-browser-action"
        "_50864413-c4c8-43b0-80b8-982c4a368ac9_-browser-action"
      ];

      dirtyAreaCache = [
        "nav-bar"
        "toolbar-menubar"
        "TabsToolbar"
        "PersonalToolbar"
        "unified-extensions-area"
      ];

      currentVersion = 20;
      newElementCount = 5;
    };
    "browser.uidensity" = 1;
    "browser.uitour.enabled" = false;
    "browser.urlbar.eventTelemetry.enabled" = false;
    "browser.urlbar.speculativeConnect.enabled" = false;
    "datareporting.healthreport.uploadEnabled" = false;
    "datareporting.policy.dataSubmissionEnabled" = false;
    "device.sensors.enabled" = false;
    "devtools.chrome.enabled" = true;
    "devtools.webextensions.@react-devtools.enabled" = true;
    "dom.push.enabled" = false;
    "dom.push.connection.enabled" = false;
    "dom.battery.enabled" = false;
    "dom.private-attribution.submission.enabled" = false;
    "extensions.abuseReport.enabled" = false;
    "extensions.activeThemeID" = "{76aabc99-c1a8-4c1e-832b-d4f2941d5a7a}";
    "extensions.pocket.api" = "";
    "extensions.formautofill.creditCards.enabled" = false;
    "extensions.InstallTrigger.enabled" = false;
    "extensions.pocket.enabled" = false;
    "extensions.systemAddon.update.enabled" = false;
    "extensions.update.autoUpdateDefault" = false;
    "extensions.webextensions.ExtensionStorageIDB.migrated.${firefoxAddons.laboratory-by-mozilla.addonId}" = true;
    "extensions.webextensions.ExtensionStorageIDB.migrated.${firefoxAddons.facebook-container.addonId}" = true;
    "extensions.webextensions.ExtensionStorageIDB.migrated.${firefoxAddons.react-devtools.addonId}" = true;
    "extensions.webextensions.ExtensionStorageIDB.migrated.${firefoxAddons.multi-account-containers.addonId}" = true;
    "extensions.webextensions.ExtensionStorageIDB.migrated.${firefoxAddons.canvasblocker.addonId}" = true;
    "extensions.webextensions.ExtensionStorageIDB.migrated.${firefoxAddons.darkreader.addonId}" = true;
    "extensions.webextensions.ExtensionStorageIDB.migrated.${firefoxAddons.tabliss.addonId}" = true;
    "extensions.webextensions.ExtensionStorageIDB.migrated.${firefoxAddons.i-dont-care-about-cookies.addonId}" = true;
    "extensions.webextensions.ExtensionStorageIDB.migrated.${firefoxAddons.hoppscotch.addonId}" = true;
    "extensions.webextensions.ExtensionStorageIDB.migrated.screenshots@mozilla.org" = true;
    "extensions.webextensions.ExtensionStorageIDB.migrated.${firefoxAddons.sponsorblock.addonId}" = true;
    "extensions.webextensions.ExtensionStorageIDB.migrated.${firefoxAddons.tree-style-tab.addonId}" = true;
    "extensions.webextensions.ExtensionStorageIDB.migrated.${firefoxAddons.ublock-origin.addonId}" = true;
    "extensions.webextensions.ExtensionStorageIDB.migrated.webpconverter@hilberteikelboom.nl" = true;
    "extensions.webextensions.ExtensionStorageIDB.migrated.{3579f63b-d8ee-424f-bbb6-6d0ce3285e6a}" = true;
    "extensions.webextensions.ExtensionStorageIDB.migrated.{446900e4-71c2-419f-a6a7-df9c091e268b}" = true;
    "extensions.webextensions.ExtensionStorageIDB.migrated.{50864413-c4c8-43b0-80b8-982c4a368ac9}" = true;
    "extensions.webextensions.ExtensionStorageIDB.migrated.${firefoxAddons.clearurls.addonId}" = true;
    "extensions.webextensions.ExtensionStorageIDB.migrated.${firefoxAddons.return-youtube-dislikes.addonId}" = true;
    "extensions.webextensions.ExtensionStorageIDB.migrated.{802a552e-13d1-4683-a40a-1e5325fba4bb}" = true;
    "extensions.webextensions.ExtensionStorageIDB.migrated.${firefoxAddons.temporary-containers.addonId}" = true;
    "extensions.webextensions.ExtensionStorageIDB.migrated.${firefoxAddons.unpaywall.addonId}" = true;
    "extensions.webcompat-reporter.enabled" = false;
    "full-screen-api.ignore-widgets" = true;
    "general.autoScroll" = true;
    "general.smoothScroll" = true;
    "geo.enabled" = false;
    "gfx.webrender.all" = true; # See https://github.com/elFarto/nvidia-vaapi-driver?tab=readme-ov-file#firefox
    "identity.fxaccounts.enabled" = false;
    "identity.fxaccounts.toolbar.enabled" = false;
    "identity.fxaccounts.pairing.enabled" = false;
    "identity.fxaccounts.commands.enabled" = false;
    "intl.accept_languages" = "en-US,en";
    "layout.css.devPixelsPerPx" = "1";
    "layout.spellCheckDefault" = 0;
    "media.eme.enabled" = false;
    "media.ffmpeg.vaapi.enabled" = true;
    "media.ffvpx.enabled" = false;
    "media.rdd-ffmpeg.enabled" = true;
    "media.rdd-vpx.enabled" = true;
    "network.dns.echconfig.enabled" = true;
    "network.predictor.enabled" = false;
    "network.proxy.socks_remote_dns" = true; # Do DNS lookup through proxy (required for tor to work)
    "privacy.clearOnShutdown.history" = false;
    "privacy.donottrackheader.enabled" = true;
    "privacy.trackingprotection.enabled" = true;
    "privacy.trackingprotection.socialtracking.enabled" = true;
    "privacy.userContext.enabled" = true;
    "privacy.userContext.ui.enabled" = true;
    "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
    "toolkit.telemetry.archive.enabled" = false;
    "toolkit.telemetry.enabled" = false;
    "toolkit.telemetry.pioneer-new-studies-available" = false;
    "toolkit.telemetry.server" = "";
    "toolkit.telemetry.unified" = false;
    "trailhead.firstrun.branches" = "nofirstrun-empty";
    "trailhead.firstrun.didSeeAboutWelcome" = true;
    "widget.dmabuf.force-enabled" = true;
  };
in
  toJSONFieldConversion config
