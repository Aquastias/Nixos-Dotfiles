{
  pkgs,
  lib,
  specialArgs,
  config,
  ...
}: let
  inherit (specialArgs) firefoxAddons;
in {
  programs.firefox = {
    # https://gitlab.com/engmark/root/-/blob/60468eb82572d9a663b58498ce08fafbe545b808/configuration.nix#L293-310
    # https://github.com/Kreyren/nixos-config/blob/bd4765eb802a0371de7291980ce999ccff59d619/nixos/users/kreyren/home/modules/web-browsers/firefox/firefox.nix
    # https://github.com/gvolpe/nix-config/blob/6feb7e4f47e74a8e3befd2efb423d9232f522ccd/home/programs/browsers/firefox.nix
    enable = true;
    languagePacks = ["en-US"];
    package = pkgs.firefox;
    # Refer to https://mozilla.github.io/policy-templates or `about:policies#documentation` in firefox
    policies = {
      "3rdparty" = {
        Extensions = {
          "uBlock0@raymondhill.net".adminSettings = {
            userSettings = rec {
              uiTheme = "dark";
              uiAccentCustom = true;
              uiAccentCustom0 = "#8300ff";
              cloudStorageEnabled = lib.mkForce false;
              importedLists = [
                "https://filters.adtidy.org/extension/ublock/filters/3.txt"
                "https://github.com/DandelionSprout/adfilt/raw/master/LegitimateURLShortener.txt"
              ];
              externalLists = lib.concatStringsSep "\n" importedLists;
            };
            selectedFilterLists = [
              "CZE-0"
              "adguard-generic"
              "adguard-annoyance"
              "adguard-social"
              "adguard-spyware-url"
              "easylist"
              "easyprivacy"
              "https://github.com/DandelionSprout/adfilt/raw/master/LegitimateURLShortener.txt"
              "plowe-0"
              "ublock-abuse"
              "ublock-badware"
              "ublock-filters"
              "ublock-privacy"
              "ublock-quick-fixes"
              "ublock-unbreak"
              "urlhaus-1"
            ];
          };
        };
      }; # Set policies that WebExtensions can access via chrome.storage.managed.
      AllowedDomainsForApps = ""; # Define domains allowed to access Google Workspace.
      AllowFileSelectionDialogs = true; # Allow file selection dialogs.
      AppAutoUpdate = false; # Enable or disable automatic application update.
      AppUpdatePin = ""; # Prevent Firefox from being updated beyond the specified version.
      AppUpdateURL = ""; # Change the URL for application update.
      # Authentication = {
      #   "SPNEGO" = [
      #     "mydomain.com"
      #     "https://myotherdomain.com"
      #   ];
      #   "Delegated" = [
      #     "mydomain.com"
      #     "https://myotherdomain.com"
      #   ];
      #   "NTLM" = [
      #     "mydomain.com"
      #     "https://myotherdomain.com"
      #   ];
      #   "AllowNonFQDN" = {
      #     "SPNEGO" = true;
      #     "NTLM" = true;
      #   };
      #   "AllowProxies" = {
      #     "SPNEGO" = true;
      #     "NTLM" = true;
      #   };
      #   "Locked" = true;
      #   "PrivateBrowsing" = true;
      # }; # Configure sites that support integrated authentication.
      AutofillAddressEnabled = false; # Enable autofill for addresses.
      AutofillCreditCardEnabled = false; # Enable autofill for payment methods.
      # AutoLaunchProtocolsFromOrigins = [
      #   {
      #     protocol = "zoommtg";
      #     allowed_origins = [ "https://somesite.zoom.us" ];
      #   }
      # ]; # Define a list of external protocols that can be used from listed origins without prompting the user.
      BackgroundAppUpdate = false; # Enable or disable the background updater (Windows only).
      BlockAboutAddons = false; # Block access to the Add-ons Manager (about:addons).
      BlockAboutConfig = false; # Block access to about:config.
      BlockAboutProfiles = false; # Block access to About Profiles (about:profiles).
      BlockAboutSupport = false; # Block access to Troubleshooting Information (about:support).
      # Bookmarks = [
      #   {
      #     Title = "Example";
      #     URL = "https://example.com";
      #     Favicon = "https://example.com/favicon.ico";
      #     Placement = "toolbar"; # toolbar | menu
      #     Folder = "FolderName";
      #   }
      # ]; # Add bookmarks in either the bookmarks toolbar or menu.
      CaptivePortal = true; # Enable or disable the detection of captive portals.
      # Certificates = {
      #   # Trust certificates that have been added to the operating system certificate store by a user or administrator.
      #   ImportEnterpriseRoots = true;
      #   # Install certificates into the Firefox certificate store.
      #   Install = [
      #     "cert1.der"
      #     "/home/username/cert2.pem"
      #   ];
      # };
      Containers = {
        Default = [
          {
            color = "turquoise";
            icon = "pet";
            name = "My container";
          }
        ];
      }; # Set policies related to containers.
      # ContentAnalysis = {
      #   AgentName = "My DLP Product";
      #   AgentTimeout = 60;
      #   AllowUrlRegexList = [
      #     "https://example\\.com/.*"
      #     "https://subdomain\\.example\\.com/.*"
      #   ];
      #   BypassForSameTabOperations = false;
      #   ClientSignature = "My DLP Company";
      #   DefaultResult = 0;
      #   DenyUrlRegexList = [
      #     "https://example\\.com/.*"
      #     "https://subdomain\\.example\\.com/.*"
      #   ];
      #   Enabled = true;
      #   IsPerUser = false;
      #   PipePathName = "pipe_custom_name";
      #   ShowBlockedResult = false;
      # }; # Configure Firefox to use an agent for Data Loss Prevention (DLP) that is compatible with the Google Chrome Content Analysis Connector Agent SDK.
      Cookies = {
        Allow = [];
        AllowSession = [];
        Block = [];
        Locked = false;
        Behavior = "reject-tracker"; # "accept" | "reject-foreign" | "reject" | "limit-foreign" | "reject-tracker" | "reject-tracker-and-partition-foreign"
        BehaviorPrivateBrowsing = "reject-tracker-and-partition-foreign";
      }; # Configure cookie preferences.
      # DefaultDownloadDirectory = ""; # Set the default download directory.
      DisableAppUpdate = true; # Turn off application updates.
      DisableBuiltinPDFViewer = true; # Disable the built in PDF viewer.
      # DisabledCiphers = {
      #   CIPHER_NAME = true;
      # }; # Disabled ciphers.
      DisableDefaultBrowserAgent = false; # Prevent the default browser agent from taking any actions (Windows only).
      DisableDeveloperTools = false; # Remove access to all developer tools.
      DisableEncryptedClientHello = false; # Disable the TLS Feature Encrypted Client Hello (ECH).
      DisableFeedbackCommands = false; # Disable the menus for reporting sites.
      DisableFirefoxAccounts = true; # Disable Firefox Accounts integration (Sync).
      DisableFirefoxScreenshots = true; # Remove access to Firefox Screenshots.
      DisableFirefoxStudies = true; # Disable Firefox studies (Shield).
      DisableForgetButton = true; # Disable the “Forget” button.
      DisableFormHistory = false; # Turn off saving information on web forms and the search bar.
      DisableMasterPasswordCreation = true; # Remove the master password functionality.
      DisablePasswordReveal = true; # Do not allow passwords to be revealed in saved logins.
      DisablePocket = true; # Remove Pocket in the Firefox UI.
      DisablePrivateBrowsing = false; # Remove access to private browsing.
      DisableProfileImport = true; # Disables the “Import data from another browser” option in the bookmarks window.
      DisableProfileRefresh = true; # Disable the Refresh Firefox button on about:support and support.mozilla.org
      DisableSafeMode = false; # Disable safe mode within the browser.
      DisableSecurityBypass = false; # Prevent the user from bypassing security in certain cases.
      DisableSetDesktopBackground = true; # Remove the “Set As Desktop Background…” menuitem when right clicking on an image.
      DisableSystemAddonUpdate = true; # Prevent system add-ons from being installed or updated.
      DisableTelemetry = true; # Disable telemetry
      DisableThirdPartyModuleBlocking = false; # Do not allow blocking third-party modules.
      DisplayBookmarksToolbar = true; # Set the initial state of the bookmarks toolbar.
      DisplayMenuBar = "default-off"; # Set the state of the menubar. "always" | "never" | "default-on" |"default-off"
      # DNSOverHTTPS = {
      #   Enabled = true; # Change to true or false as needed
      #   ProviderURL = "URL_TO_ALTERNATE_PROVIDER"; # Replace with your actual URL
      #   Locked = false; # Change to true or false as needed
      #   ExcludedDomains = [ "example.com" ];
      #   Fallback = true; # Change to true or false as needed
      # }; # Configure DNS over HTTPS.
      DontCheckDefaultBrowser = true; # Don’t check if Firefox is the default browser at startup.
      # DownloadDirectory 	Set and lock the download directory.
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
        # Exceptions = [ "https://example.com" ];
      }; # Configure tracking protection.
      EncryptedMediaExtensions = {
        Enabled = true;
        Locked = true;
      }; # Enable or disable Encrypted Media Extensions and optionally lock it.
      EnterprisePoliciesEnabled = true; # Enable policy support on macOS.
      # ExemptDomainFileTypePairsFromFileTypeDownloadWarnings = [
      #   {
      #     file_extension = "jnlp";
      #     domains = [ "example.com" ];
      #   }
      # ]; # Disable warnings based on file extension for specific file types on domains.
      ExtensionSettings = with builtins; let
        blockedExtension = {
          name = "*";
          value = {
            installation_mode = "blocked"; # allowed" | "blocked" | "force_installed" | "normal_installed".
            blocked_install_message = "Extension blocked!";
          };
        };
        extension = shortId: uuid: {
          name = uuid;
          value = {
            install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/${shortId}/latest.xpi";
            installation_mode = "normal_installed";
          };
        };
      in
        listToAttrs [
          # Check about:support for extension/add-on ID strings.
          blockedExtension
          (extension "betterttv" firefoxAddons.betterttv.addonId)
          (extension "bitwarden-password-manager" "{446900e4-71c2-419f-a6a7-df9c091e268b}")
          (extension "clearurls" firefoxAddons.clearurls.addonId)
          (extension "canvasblocker" firefoxAddons.canvasblocker.addonId)
          (extension "darkreader" firefoxAddons.darkreader.addonId)
          (extension "facebook-container" firefoxAddons.facebook-container.addonId)
          (extension "hoppscotch" firefoxAddons.hoppscotch.addonId)
          (extension "i-dont-care-about-cookies" firefoxAddons.i-dont-care-about-cookies.addonId)
          (extension "multi-account-containers" firefoxAddons.multi-account-containers.addonId)
          (extension "privacy-badger" firefoxAddons.privacy-badger.addonId)
          (extension "return-youtube-dislikes" firefoxAddons.return-youtube-dislikes.addonId)
          (extension "sponsorblock" firefoxAddons.sponsorblock.addonId)
          (extension "tabliss" firefoxAddons.tabliss.addonId)
          (extension "tree-style-tab" firefoxAddons.tree-style-tab.addonId)
          (extension "ublock-origin" firefoxAddons.ublock-origin.addonId)
          (extension "umatrix" firefoxAddons.umatrix.addonId)
          (extension "unpaywall" firefoxAddons.unpaywall.addonId)
          (extension "vimium" firefoxAddons.vimium.addonId)
          (extension "youtube-nonstop" firefoxAddons.youtube-nonstop.addonId)
        ]; # Control the installation, uninstallation and locking of extensions.
      ExtensionUpdate = false; # Control extension updates.
      FirefoxHome = {
        Search = true;
        TopSites = true;
        SponsoredTopSites = false;
        Highlights = true;
        Pocket = false;
        SponsoredPocket = false;
        Snippets = false;
        Locked = true;
      }; # Customize the Firefox Home page.
      FirefoxSuggest = {
        WebSuggestions = false;
        SponsoredSuggestions = false;
        ImproveSuggest = false;
        Locked = true;
      }; # Customize Firefox Suggest.
      GoToIntranetSiteForSingleWordEntryInAddressBar = true; # Force direct intranet site navigation instead of searching when typing single word entries in the address bar.
      Handlers = {
        mimeTypes = {
          "application/pdf" = {
            action = "saveToDisk";
          };
        };
        schemes = {
          mailto = {
            handlers = [null];
          };
        };
      }; # Configure default application handlers.
      HardwareAcceleration = true; # Control hardware acceleration.
      Homepage = {
        URL = "https://searx.work";
        Locked = true;
        Additional = [];
        StartPage = "homepage"; # Change to "homepage", "previous-session", or "homepage-locked" as needed
      }; # Configure the default homepage and how Firefox starts.
      HttpAllowlist = ["http://localhost:3000"]; # Configure origins that will not be upgraded to HTTPS.
      HttpsOnlyMode = "force_enabled"; # Configure HTTPS-Only Mode. "allowed" | "disallowed" | "enabled" | "force_enabled"
      InstallAddonsPermission = {
        Allow = [];
        Default = false;
      }; # Configure the default extension install policy as well as origins for extension installs are allowed.
      LegacyProfiles = false; # Disable the feature enforcing a separate profile for each installation.
      LegacySameSiteCookieBehaviorEnabled = false; # Enable default legacy SameSite cookie behavior setting.
      LegacySameSiteCookieBehaviorEnabledForDomainList = []; # Revert to legacy SameSite behavior for cookies on specified sites.
      LocalFileLinks = []; # Enable linking to local files by origin.
      ManagedBookmarks = []; # Configures a list of bookmarks managed by an administrator that cannot be changed by the user.
      ManualAppUpdateOnly = false; # Allow manual updates only and do not notify the user about updates.
      NetworkPrediction = true; # Enable or disable network prediction (DNS prefetching).
      NewTabPage = true; # Enable or disable the New Tab page.
      NoDefaultBookmarks = true; # Disable the creation of default bookmarks.
      OfferToSaveLogins = false; # Control whether or not Firefox offers to save passwords.
      OfferToSaveLoginsDefault = false; # Set the default value for whether or not Firefox offers to save passwords.
      OverrideFirstRunPage = ""; # Override the first run page.
      OverridePostUpdatePage = ""; # Override the upgrade page.
      PasswordManagerEnabled = false; # Remove (some) access to the password manager.
      PasswordManagerExceptions = []; # Prevent Firefox from saving passwords for specific sites.
      PDFjs = {
        Enabled = false;
        EnablePermissions = false;
      }; # Disable or configure PDF.js, the built-in PDF viewer.
      Permissions = {
        Camera = {
          Allow = [];
          Block = [];
          BlockNewRequests = true;
          Locked = true;
        };
        Microphone = {
          Allow = [];
          Block = [];
          BlockNewRequests = true;
          Locked = true;
        };
        Location = {
          Allow = [];
          Block = [];
          BlockNewRequests = true;
          Locked = true;
        };
        Notifications = {
          Allow = [];
          Block = [];
          BlockNewRequests = true;
          Locked = true;
        };
        Autoplay = {
          Allow = [];
          Block = [];
          Default = "allow-audio-video"; # Change to "block-audio" or "block-audio-video" as needed
          Locked = true;
        };
      }; # Set permissions associated with camera, microphone, location, and notifications.
      PictureInPicture = {
        Enabled = true;
        Locked = true;
      }; # Enable or disable Picture-in-Picture.
      PopupBlocking = {
        Allow = [];
        Default = false;
        Locked = true;
      }; # Configure the default pop-up window policy as well as origins for which pop-up windows are allowed.
      PostQuantumKeyAgreementEnabled = true; # Enable post-quantum key agreement for TLS.
      Preferences = {}; # Set and lock preferences.
      PrimaryPassword = false; # Require or prevent using a primary (formerly master) password.
      PrintingEnabled = true; # Enable or disable printing.
      PrivateBrowsingModeAvailability = 0; # Set availability of private browsing mode. 0 - available, 1 - not available, 2 - forced
      PromptForDownloadLocation = true; # Ask where to save each file before downloading.
      Proxy = {
        Mode = "system"; # none | system | manual | autoDetect | autoConfig;
        Locked = true;
        # HTTPProxy = hostname;
        # UseHTTPProxyForAllProtocols = true;
        # SSLProxy = hostname;
        # FTPProxy = hostname;
        SOCKSProxy = "127.0.0.1:9050"; # Tor
        SOCKSVersion = 5; # 4 | 5
        #Passthrough = <local>;
        # AutoConfigURL = URL_TO_AUTOCONFIG;
        # AutoLogin = true;
        UseProxyForDNS = true;
      }; # Configure proxy settings.
      RequestedLocales = ["en-US"]; # Set the the list of requested locales for the application in order of preference.
      SanitizeOnShutdown = {
        Cache = true;
        Cookies = false;
        History = false;
        Sessions = false;
        SiteSettings = false;
        Locked = true;
      }; # Clear data on shutdown
      SearchBar = "separate"; # Set whether or not search bar is displayed. "unified" | "separate"
      # SearchEngines = {
      #   PreventInstalls = true;
      #   Add = [
      #     {
      #       Name = "Nix Packages";
      #       URLTemplate = "https://search.nixos.org/packages";
      #       Method = "GET";
      #       IconURL = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
      #       Alias = "@np";
      #       Description = "Search for Nix packages.";
      #       PostData = "type=packages&query={searchTerms}";
      #     }
      #   ];
      #   Remove = [
      #     "Amazon.com"
      #     "Bing"
      #     "Google"
      #   ];
      #   Default = "SearXNG";
      # }; # Add new search engines. Works only for ESR.
      SearchSuggestEnabled = false; # Enable search suggestions.
      # SecurityDevices = {
      #   Add = {
      #     NAME_OF_DEVICE_TO_ADD = "PATH_TO_LIBRARY_FOR_DEVICE";
      #   };
      #   Delete = [ "NAME_OF_DEVICE_TO_DELETE" ];
      # }; # Install PKCS #11 modules.
      ShowHomeButton = true; # Show the home button on the toolbar.
      # SSLVersionMax = "tls1.3"; # Set and lock the maximum version of TLS.
      # SSLVersionMin = "tls1.3"; # Set and lock the minimum version of TLS.
      StartDownloadsInTempDirectory = false; # Force downloads to start off in a local, temporary location rather than the default download directory.
      SupportMenu = true; # Add a menuitem to the help menu for specifying support information.
      TranslateEnabled = false; # Enable or disable webpage translation.
      UserMessaging = {
        ExtensionRecommendations = false; # Don’t recommend extensions while the user is visiting web pages
        FeatureRecommendations = false; # Don’t recommend browser features
        Locked = true; # Prevent the user from changing user messaging preferences
        MoreFromMozilla = false; # Don’t show the “More from Mozilla” section in Preferences
        SkipOnboarding = true; # Don’t show onboarding messages on the new tab page
        UrlbarInterventions = false; # Don’t offer suggestions in the URL bar
        WhatsNew = false; # Remove the “What’s New” icon and menuitem
      }; # Don’t show certain messages to the user.
      UseSystemPrintDialog = true; # Print using the system print dialog instead of print preview.
      WebsiteFilter = {
        Block = [];
        Exceptions = [];
      }; # Block websites from being visited.
      WindowsSSO = false; # Allow Windows single sign-on for Microsoft, work, and school accounts.
    };
    arkenfox = {
      enable = false;
      version = "130.0";
    };
    profiles = {
      default = {
        id = 0;
        isDefault = true;
        name = "default";
        # Documentation https://arkenfox.dwarfmaster.net
        arkenfox = {
          enable = true;

          # STARTUP
          "0105".enable = true; # Disable sponsored content on Firefox Home (Activity Stream)

          # GEOLOCATION / LANGUAGE / LOCALE
          "0201".enable = true; # Use Mozilla geolocation service instead of Google if permission is granted [FF74+]
          "0202".enable = true; # Disable using the OS's geolocation service
          # WARNING(Krey): May break some input methods e.g xim/ibus for CJK languages [1]
          "0211".enable = true; # Use en-US locale regardless of the system or region locale

          # QUIETER FOX (Handles telemetry, etc..)
          "0300".enable = true;

          # BLOCK IMPLICIT OUTBOUND [not explicitly asked for - e.g. clicked on]
          "0600".enable = true;

          # DNS / DoH / PROXY / SOCKS / IPV6
          "0701".enable = true; # Disable IPv6 as it's potentially leaky
          "0704".enable = true; # Disable GIO as a potential proxy bypass vector

          # LOCATION BAR / SEARCH BAR / SUGGESTIONS / HISTORY / FORMS
          "0802".enable = true; # disable location bar domain guessing

          # PASSWORDS
          "0900".enable = true;

          # HTTPS (SSL/TLS / OCSP / CERTS / HPKP)
          "1200".enable = true;

          # FONTS
          "1400".enable = true;

          # HEADERS ? REFERERS
          "1600".enable = true;

          # CONTAINERS
          "1700".enable = true;

          # PLUGINS / MEDIA / WEBRTC
          "2002".enable = true; # Force WebRTC inside the proxy [FF70+]
          "2003".enable = true; # Force a single network interface for ICE candidates generation [FF42+]
          "2004".enable = true; # Force exclusion of private IPs from ICE candidates [FF51+]
          "2020".enable = true; # Disable GMP (Gecko Media Plugins) - https://wiki.mozilla.org/GeckoMediaPlugins

          # DOM (DOCUMENT OBJECT MODEL)
          "2400".enable = true; # Prevent scrips from resizing open windows (could be used for fingerprinting)

          # MISCELLANEOUS
          "2603".enable = true; # Remove temp files opened with an external application on exit
          "2606".enable = true; # Disable UITour backend so there is no chance that a remote page can use it
          "2608".enable = true; # Reset remote debugging to disabled
          "2615".enable = true; # Disable websites overriding Firefox's keyboard shortcuts [FF58+]
          "2616".enable = true; # Remove special permissions for certain mozilla domains [FF35+]
          "2617".enable = true; # Remove webchannel whitelist (Seems to be deprecated with mozilla having still permissions in it)
          "2619".enable = true; # Use Punycode in Internationalized Domain Names to eliminate possible spoofing
          "2620".enable = true; # Enforce PDFJS, disable PDFJS scripting
          "2621".enable = true; # Disable links launching Windows Store on Windows 8/8.1/10 [WINDOWS]
          "2623".enable = true; # Disable permissions delegation [FF73+], Disabling delegation means any prompts for these will show/use their correct 3rd party origin
          "2624".enable = true; # Disable middle click on new tab button opening URLs or searches using clipboard [FF115+]
          "2651".enable = true; # Enable user interaction for security by always asking where to download
          "2652".enable = true; # Disable downloads panel opening on every download [FF96+]
          "2654".enable = true; # Enable user interaction for security by always asking how to handle new mimetypes [FF101+]
          "2662".enable = true; # Disable webextension restrictions on certain mozilla domains (you also need 4503) [FF60+]
          "4503".enable = true; # Disable mozAddonManager Web API [FF57+]

          # ETP (ENHANCED TRACKING PROTECTION)
          "2700".enable = true;

          "2811".enable = true; # Set/enforce what items to clear on shutdown (if 2810 is true) [SETUP-CHROME]
          "2812".enable = true; # Set Session Restore to clear on shutdown (if 2810 is true) [FF34+]
          "2815".enable = true; # Set "Cookies" and "Site Data" to clear on shutdown (if 2810 is true) [SETUP-CHROME]

          # EFP (RESIST FINGERPRINTING)
          "4500".enable = true;

          # OPTIONAL OPSEC
          "5003".enable = true; # Disable saving passwords
          "5004".enable = true; # Disable permissions manager from writing to disk [FF41+] [RESTART], This means any permission changes are session only

          # OPTIONAL HARDENING
          # There are new vulnerabilities discovered in 2023, better disable it for now
          "5505".enable = true; # Disable Ion and baseline JIT to harden against JS exploits

          # By default arkenfox flake sets all options are set to disabled, and these are expected to be always enabled
          "6000".enable = true;

          # DONT BOTHER
          "7001".enable = true; # Disables Location-Aware Browsing, Full Screen Geo is behind a prompt (7002). Full screen requires user interaction
          "7003".enable = true; # Disable non-modern cipher suites
          "7004".enable = true; # Control TLS Versions, because they are used as a passive fingerprinting
          "7005".enable = true; # Disable SSL Session IDs [FF36+]
          "7006".enable = true; # Onions
          "7007".enable = true; # References, only cross-origin referrers (1600s) need control
          "7013".enable = true; # Disable Clipboard API
          "7014".enable = true; # Disable System Add-on updates (Managed by Nix)

          # NON-PROJECT RELATED
          "9002".enable = true; # Disable General>Browsing>Recommend extensions/features as you browse [FF67+]
        };
        extraConfig = ''
          user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
          user_pref("full-screen-api.ignore-widgets", true);
          user_pref("media.ffmpeg.vaapi.enabled", true);
          user_pref("media.rdd-vpx.enabled", true);
        '';
        search = {
          force = true;
          default = "Searx";
          order = [
            "Searx"
            "DuckDuckGo"
            "Youtube"
            "NixOS Options"
            "Nix Packages"
            "GitHub"
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
              urls = [{template = "https://searx.work/?q={searchTerms}";}];
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
            "Google".metaData.alias = "@g"; # Builtin engines only support specifying one additional alias
            "Wikipedia (en)".metaData.alias = "@wiki";
            "Amazon.com".metaData.hidden = true;
            "Bing".metaData.hidden = true;
            "eBay".metaData.hidden = true;
          };
        };
        settings = {
          "browser.search.defaultenginename" = "Searx";
          "browser.search.order.1" = "Searx";
          "browser.startup.homepage" = "https://searx.work";
          "general.smoothScroll" = true;
          "network.proxy.socks_remote_dns" = true; # Do DNS lookup through proxy (required for tor to work)
        };
      };
    };
  };
}
