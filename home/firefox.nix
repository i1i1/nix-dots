{ pkgs, lib, ... }:

let
  subwallet = pkgs.fetchFirefoxAddon {
    name = "subwallet";
    url = "https://addons.mozilla.org/firefox/downloads/file/4083905/subwallet-0.8.2.xpi";
    sha256 = "sha256-0DEARaT3VD/sXf0yRe+KUVKm+yvScUBAMm5LMcyrCf4=";
  };
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
        SearchEngines = {
          Default = "DuckDuckGo";
          PreventInstalls = true;
        };
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
      extraConfig = ''
        user_pref("full-screen-api.ignore-widgets", true);
        user_pref("media.ffmpeg.vaapi.enabled", true);
        user_pref("media.rdd-vpx.enabled", true);
      '';
      userChrome = ''
        #TabsToolbar { visibility: collapse !important; }
      '';
      userContent = ''
        # Here too
      '';

      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        bitwarden
        languagetool
        metamask
        subwallet
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
        [ "text/html" "x-scheme-handler/http" "x-scheme-handler/https" ]);
}
