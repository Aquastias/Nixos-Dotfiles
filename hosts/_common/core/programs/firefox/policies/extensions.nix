{
  lib,
  specialArgs,
  configVars,
  ...
}: let
  inherit (specialArgs) firefoxAddons;

  toJSONFieldConversion = import "${configVars.functions.path}/toJSONFieldConversion.nix";

  config = let
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
    lib.listToAttrs [
      # Check about:support for extension/add-on ID strings.
      blockedExtension
      (extension "betterttv" firefoxAddons.betterttv.addonId)
      (extension "bitwarden-password-manager" "{446900e4-71c2-419f-a6a7-df9c091e268b}")
      (extension "canvasblocker" firefoxAddons.canvasblocker.addonId)
      (extension "catppuccin-mocha-lavender-git" "{8446b178-c865-4f5c-8ccc-1d7887811ae3}")
      (extension "catppuccin-mocha-mauve-git" "{76aabc99-c1a8-4c1e-832b-d4f2941d5a7a}")
      (extension "chameleon-ext" "{3579f63b-d8ee-424f-bbb6-6d0ce3285e6a}")
      (extension "clearurls" firefoxAddons.clearurls.addonId)
      (extension "country-flags-ip-whois" "{802a552e-13d1-4683-a40a-1e5325fba4bb}")
      (extension "canvasblocker" firefoxAddons.canvasblocker.addonId)
      (extension "darkreader" firefoxAddons.darkreader.addonId)
      (extension "facebook-container" firefoxAddons.facebook-container.addonId)
      (extension "fontanello" "{768bd125-21c9-41b7-9bed-ffce6c787f36}")
      (extension "hoppscotch" firefoxAddons.hoppscotch.addonId)
      (extension "i-dont-care-about-cookies" firefoxAddons.i-dont-care-about-cookies.addonId)
      (extension "laboratory-by-mozilla" firefoxAddons.laboratory-by-mozilla.addonId)
      (extension "multi-account-containers" firefoxAddons.multi-account-containers.addonId)
      (extension "privacy-badger" firefoxAddons.privacy-badger.addonId)
      (extension "react-devtools" firefoxAddons.react-devtools.addonId)
      (extension "return-youtube-dislikes" firefoxAddons.return-youtube-dislikes.addonId)
      (extension "sponsorblock" firefoxAddons.sponsorblock.addonId)
      (extension "tabliss" firefoxAddons.tabliss.addonId)
      (extension "temporary-containers" firefoxAddons.temporary-containers.addonId)
      (extension "tree-style-tab" firefoxAddons.tree-style-tab.addonId)
      (extension "ublock-origin" firefoxAddons.ublock-origin.addonId)
      # (extension "umatrix" firefoxAddons.umatrix.addonId)
      (extension "unpaywall" firefoxAddons.unpaywall.addonId)
      (extension "vimium" firefoxAddons.vimium.addonId)
      (extension "visbug" "{50864413-c4c8-43b0-80b8-982c4a368ac9}")
      (extension "webp-image-converter" "webpconverter@hilberteikelboom.nl")
      (extension "youtube-nonstop" firefoxAddons.youtube-nonstop.addonId)
    ];
in
  toJSONFieldConversion config
