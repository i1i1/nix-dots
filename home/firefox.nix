{ pkgs, lib, betterfox, ... }:

let
  firefox = with pkgs;
    wrapFirefox firefox-unwrapped {
      extraPolicies = {
        CaptivePortal = false;
        DisableFirefoxStudies = true;
        DisablePocket = true;
        DisableTelemetry = true;
        DisableFirefoxAccounts = true;
        FirefoxHome = {
          Pocket = false;
          SponsoredPocket = false;
          TopSites = false;
          SponsoredTopSites = false;
          Search = false;
          Snippets = false;
        };
        SearchEngines.PreventInstalls = true;
        UserMessaging = {
          WhatsNew = false;
          FeatureRecommentdations = false;
          UrlbarInterventions = false;
          MoreFromMozilla = false;
          ExtensionRecommendations = false;
          SkipOnboarding = true;
        };
      };

      extraPrefs = ''
        // Show more ssl cert infos
        lockPref("security.identityblock.show_extended_validation", true);

        // Enable userchrome css
        lockPref("toolkit.legacyUserProfileCustomizations.stylesheets", true);

        // Enable dark dev tools
        lockPref("devtools.theme","dark");
      '';
    };
in
{
  programs.firefox = {
    enable = true;
    package = firefox;

    profiles.i1i1 = {
      id = 0;
      isDefault = true;
      name = "i1i1";
      settings = {
        "general.smoothScroll" = true;
      };
      extraConfig = builtins.readFile "${betterfox}/user.js";
      userChrome = ''
        #TabsToolbar { visibility: collapse !important; }
      '';
      userContent = ''
        # Here too
      '';

      search = {
        force = true;
        default = "SearX";
        engines = {
          "SearX" = {
            urls = [{
              template = "https://sx.thatsverys.us/search";
              params = [{ name = "q"; value = "{searchTerms}"; }];
            }];
            suggestUrls = [{
              template = "https://sx.thatsverys.us/search";
              params = [{ name = "q"; value = "{searchTerms}"; }];
            }];
            definedAliases = [ "@s" ];
          };
          "Wikipedia (en)".metaData.hidden = true;
          "DuckDuckGo".metaData.hidden = true;
          "Google".metaData.hidden = true;
          "Amazon.com".metaData.hidden = true;
          "Bing".metaData.hidden = true;
          "eBay".metaData.hidden = true;
        };
      };

      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        bitwarden
        languagetool
        metamask
        tree-style-tab

        # Privacy
        clearurls
        decentraleyes
        disconnect
        duckduckgo-privacy-essentials
        ghostery
        # https-everywhere
        privacy-badger
        privacy-redirect
        ublock-origin

        # Create a different email for each website to hide your real email
        simplelogin
      ];
    };
  };

  home.sessionVariables.BROWSER = "firefox";
  systemd.user.sessionVariables.BROWSER = "firefox";

  xdg.mimeApps =
    let
      mimeScheme = scheme: {
        associations.added.${scheme} = [ "firefox.desktop" ];
        defaultApplications.${scheme} = [ "firefox.desktop" ];
      };
    in
    lib.lists.fold
      (a: b: a // b)
      { }
      (map
        mimeScheme
        [
          "text/html"
          "x-scheme-handler/http"
          "x-scheme-handler/https"
          "x-scheme-handler/chrome"
          "x-scheme-handler/x-extension-htm"
          "x-scheme-handler/x-extension-html"
          "x-scheme-handler/x-extension-shtml"
          "x-scheme-handler/xhtml+xml"
          "x-scheme-handler/x-extension-xhtml"
          "x-scheme-handler/x-extension-xht"
        ]);
}
