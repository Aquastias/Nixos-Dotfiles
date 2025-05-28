# Refer to https://mozilla.github.io/policy-templates or `about:policies#documentation` in Firefox
{
  lib,
  specialArgs,
  configVars,
  ...
}: let
  toJSONFieldConversion = import "${configVars.functions.path}/toJSONFieldConversion.nix";

  config = {
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
    };
    AllowedDomainsForApps = "";
    AllowFileSelectionDialogs = true;
    AppAutoUpdate = false;
    AppUpdatePin = "";
    AppUpdateURL = "";
    AutofillAddressEnabled = false;
    AutofillCreditCardEnabled = false;
    BackgroundAppUpdate = false;
    BlockAboutAddons = false;
    BlockAboutConfig = false;
    BlockAboutProfiles = false;
    BlockAboutSupport = false;
    CaptivePortal = true;
    Containers = {
      Default = [
        {
          color = "turquoise";
          icon = "pet";
          name = "My container";
        }
      ];
    };
    Cookies = {
      Allow = [];
      AllowSession = [];
      Block = [];
      Locked = false;
      Behavior = "reject-tracker";
      BehaviorPrivateBrowsing = "reject-tracker-and-partition-foreign";
    };
    DisableAppUpdate = true;
    DisableBuiltinPDFViewer = true;
    DisableDefaultBrowserAgent = false;
    DisableDeveloperTools = false;
    DisableEncryptedClientHello = false;
    DisableFeedbackCommands = false;
    DisableFirefoxAccounts = true;
    DisableFirefoxScreenshots = true;
    DisableFirefoxStudies = true;
    DisableForgetButton = true;
    DisableFormHistory = false;
    DisableMasterPasswordCreation = true;
    DisablePasswordReveal = true;
    DisablePocket = true;
    DisablePrivateBrowsing = false;
    DisableProfileImport = true;
    DisableProfileRefresh = true;
    DisableSafeMode = false;
    DisableSecurityBypass = false;
    DisableSetDesktopBackground = true;
    DisableSystemAddonUpdate = true;
    DisableTelemetry = true;
    DisableThirdPartyModuleBlocking = false;
    DisplayBookmarksToolbar = true;
    DisplayMenuBar = "default-off";
    DontCheckDefaultBrowser = true;
    EnableTrackingProtection = {
      Value = true;
      Locked = true;
      Cryptomining = true;
      Fingerprinting = true;
    };
    EncryptedMediaExtensions = {
      Enabled = true;
      Locked = true;
    };
    EnterprisePoliciesEnabled = true;
    ExtensionSettings = import ./extensions.nix {inherit configVars lib specialArgs;};
    ExtensionUpdate = false;
    FirefoxHome = {
      Search = true;
      TopSites = true;
      SponsoredTopSites = false;
      Highlights = true;
      Pocket = false;
      SponsoredPocket = false;
      Snippets = false;
      Locked = true;
    };
    FirefoxSuggest = {
      WebSuggestions = false;
      SponsoredSuggestions = false;
      ImproveSuggest = false;
      Locked = true;
    };
    GoToIntranetSiteForSingleWordEntryInAddressBar = true;
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
    };
    HardwareAcceleration = true;
    Homepage = {
      URL = "https://search.brave.com/";
      Locked = true;
      Additional = [];
      StartPage = "homepage";
    };
    HttpAllowlist = ["http://localhost:3000"];
    HttpsOnlyMode = "force_enabled";
    InstallAddonsPermission = {
      Allow = [];
      Default = false;
    };
    LegacyProfiles = false;
    LegacySameSiteCookieBehaviorEnabled = false;
    LegacySameSiteCookieBehaviorEnabledForDomainList = [];
    LocalFileLinks = [];
    ManagedBookmarks = [];
    ManualAppUpdateOnly = false;
    NetworkPrediction = true;
    NewTabPage = true;
    NoDefaultBookmarks = false;
    OfferToSaveLogins = false;
    OfferToSaveLoginsDefault = false;
    OverrideFirstRunPage = "";
    OverridePostUpdatePage = "";
    PasswordManagerEnabled = false;
    PasswordManagerExceptions = [];
    PDFjs = {
      Enabled = false;
      EnablePermissions = false;
    };
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
        Default = "allow-audio-video";
        Locked = true;
      };
    };
    PictureInPicture = {
      Enabled = true;
      Locked = true;
    };
    PopupBlocking = {
      Allow = [];
      Default = false;
      Locked = true;
    };
    PostQuantumKeyAgreementEnabled = true;
    Preferences = import ./preferences.nix {inherit configVars specialArgs;};
    PrimaryPassword = false;
    PrintingEnabled = true;
    PrivateBrowsingModeAvailability = 0;
    PromptForDownloadLocation = true;
    Proxy = {
      Mode = "system";
      Locked = true;
      SOCKSProxy = "127.0.0.1:9050";
      SOCKSVersion = 5;
      UseProxyForDNS = true;
    };
    RequestedLocales = ["en-US"];
    SanitizeOnShutdown = {
      Cache = true;
      Cookies = false;
      History = false;
      Sessions = false;
      SiteSettings = false;
      Locked = true;
    };
    SearchBar = "unified";
    SearchSuggestEnabled = false;
    ShowHomeButton = true;
    StartDownloadsInTempDirectory = false;
    SupportMenu = true;
    TranslateEnabled = false;
    UserMessaging = {
      ExtensionRecommendations = false;
      FeatureRecommendations = false;
      Locked = true;
      MoreFromMozilla = false;
      SkipOnboarding = true;
      UrlbarInterventions = false;
      WhatsNew = false;
    };
    UseSystemPrintDialog = true;
    WebsiteFilter = {
      Block = [];
      Exceptions = [];
    };
    WindowsSSO = false;
  };
in
  toJSONFieldConversion config
