{ pkgs, ... }:

with pkgs; wrapFirefox firefox-esr-unwrapped {
  nixExtensions = [
    (fetchFirefoxAddon {
      name = "ublock";
      url = "https://addons.mozilla.org/firefox/downloads/file/3679754/ublock_origin-1.31.0-an+fx.xpi";
      sha256 = "1h768ljlh3pi23l27qp961v1hd0nbj2vasgy11bmcrlqp40zgvnr";
    })
    (fetchFirefoxAddon {
      name = "tree-style-tab";
      url = "https://addons.mozilla.org/firefox/downloads/file/4053198/tree_style_tab-3.9.12.xpi";
      sha256 = "sha256-ii47IjdWwLqQlg7N3GTSgrTcgpOhwYyaGwx3kp3Kpbg=";
    })
  ];

  extraPolicies = {
    CaptivePortal = false;
    DisableFirefoxStudies = true;
    DisablePocket = true;
    DisableTelemetry = true;
    DisableFirefoxAccounts = true;
    FirefoxHome = {
      Pocket = false;
      Snippets = false;
    };
    SearchEngines = {
      Default = "DuckDuckGo";
      PreventInstalls = true;
    };
    UserMessaging = {
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
}
