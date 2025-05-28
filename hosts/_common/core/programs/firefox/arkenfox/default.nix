{...}: let
  # Documentation https://arkenfox.dwarfmaster.net
  defaultArkenfox = {
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
in {
  programs.firefox = {
    arkenfox = {
      enable = false;
      version = "130.0";
    };

    profiles.default = {
      arkenfox = defaultArkenfox;
    };
  };
}
