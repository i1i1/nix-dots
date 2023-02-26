{ pkgs, lib, ... }:

let
  firefox = with pkgs;
    wrapFirefox firefox-esr-unwrapped {
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
        (fetchFirefoxAddon {
          name = "languagetool";
          url = "https://addons.mozilla.org/firefox/downloads/file/4034972/languagetool-6.0.1.xpi";
          sha256 = "sha256-pyQ5JY1+k3Ylt2KrTjXifYC927G/nFeUfmXslNhYfnk=";
        })
        (fetchFirefoxAddon {
          name = "bitwarden";
          url = "https://addons.mozilla.org/firefox/downloads/file/4054938/bitwarden_password_manager-2023.1.0.xpi";
          sha256 = "sha256-sQeTD90AWqxpRiIquLgMeJ8XvY5szWnE9KHP4QKxyWQ=";
        })
        (fetchFirefoxAddon {
          name = "metamask";
          url = "https://addons.mozilla.org/firefox/downloads/file/4037096/ether_metamask-10.22.2.xpi";
          sha256 = "sha256-G+MwJDOcsaxYSUXjahHJmkWnjLeQ0Wven8DU/lGeMzA=";
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

  home.packages = [ firefox ];
}
