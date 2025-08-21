{ lib, pkgs, ... }:
let
  inherit (lib) concatStringsSep escapeShellArg mapAttrsToList;

  env = {
    MOZ_WEBRENDER = 1;
    MOZ_USE_XINPUT2 = 1;
  };
  envStr = concatStringsSep " " (mapAttrsToList (n: v: "${n}=${escapeShellArg v}") env);

  betterfox = pkgs.fetchFromGitHub {
    owner = "yokoffing";
    repo = "Betterfox";
    rev = "128.0";
    hash = "sha256-Xbe9gHO8Kf9C+QnWhZr21kl42rXUQzqSDIn99thO1kE=";
  };

  commonExtraConfig = builtins.concatStringsSep "\n" [
    (builtins.readFile "${betterfox}/Securefox.js")
    (builtins.readFile "${betterfox}/Fastfox.js")
    (builtins.readFile "${betterfox}/Peskyfox.js")
  ];

  commonSettings = {
    "browser.tabs.loadInBackground" = true;
    "widget.gtk.rounded-bottom-corners.enabled" = true;
    "gnomeTheme.hideSingleTab" = true;
    "gnomeTheme.bookmarksToolbarUnderTabs" = true;
    "gnomeTheme.normalWidthTabs" = false;
    "gnomeTheme.tabsAsHeaderbar" = false;
    "browser.fullscreen.autohide" = false;
    "intl.accept_languages" = "en-US,en";
    "browser.startup.page" = 3;
    "browser.aboutConfig.showWarning" = false;
    "browser.ctrlTab.sortByRecentlyUsed" = false;
    "browser.download.useDownloadDir" = false;
    "browser.translations.neverTranslateLanguages" = "de";
    "privacy.clearOnShutdown.history" = false;
    "devtools.chrome.enabled" = true;
    "browser.tabs.crashReporting.sendReport" = false;
    "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
    "svg.context-properties.content.enabled" = false;
    "browser.newtabpage.activity-stream.newtabWallpapers.enabled" = false;
    "browser.newtabpage.activity-stream.newtabWallpapers.v2.enabled" = false;
    "widget.non-native-theme.scrollbar.style" = 0;
    "accessibility.typeaheadfind.enablesound" = false;
    "general.autoScroll" = true;
    "gfx.webrender.all" = true;
    "media.ffmpeg.vaapi.enabled" = true;
    "media.rdd-ffmpeg.enabled" = true;
    "widget.dmabuf.force-enabled" = true;
    "media.av1.enabled" = false;
    "media.ffvpx.enabled" = false;
    "media.rdd-vpx.enabled" = false;
    "privacy.donottrackheader.enabled" = true;
    "privacy.trackingprotection.enabled" = true;
    "privacy.trackingprotection.socialtracking.enabled" = true;
    "privacy.userContext.enabled" = true;
    "privacy.userContext.ui.enabled" = true;
    "browser.send_pings" = false;
    "app.normandy.enabled" = false;
    "app.shield.optoutstudies.enabled" = false;
    "beacon.enabled" = false;
    "device.sensors.enabled" = false;
    "geo.enabled" = false;
    "network.dns.echconfig.enabled" = true;
    "toolkit.telemetry.archive.enabled" = false;
    "toolkit.telemetry.enabled" = false;
    "toolkit.telemetry.server" = "";
    "toolkit.telemetry.unified" = false;
    "extensions.webcompat-reporter.enabled" = false;
    "datareporting.policy.dataSubmissionEnabled" = false;
    "datareporting.healthreport.uploadEnabled" = false;
    "browser.ping-centre.telemetry" = false;
    "browser.urlbar.eventTelemetry.enabled" = false;
    "extensions.pocket.enabled" = false;
    "extensions.abuseReport.enabled" = false;
    "extensions.formautofill.creditCards.enabled" = false;
    "identity.fxaccounts.enabled" = false;
    "identity.fxaccounts.toolbar.enabled" = false;
    "identity.fxaccounts.pairing.enabled" = false;
    "identity.fxaccounts.commands.enabled" = false;
    "browser.contentblocking.report.lockwise.enabled" = false;
    "browser.uitour.enabled" = false;
    "browser.newtabpage.activity-stream.showSponsored" = false;
    "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
    "browser.eme.ui.enabled" = false;
    "media.eme.enabled" = false;
    "network.predictor.enabled" = false;
    "browser.urlbar.speculativeConnect.enabled" = false;
    "dom.push.enabled" = false;
    "dom.push.connection.enabled" = false;
    "dom.battery.enabled" = false;
    "signon.autofillForms" = false;
    "signon.firefoxRelay.feature" = "disabled";
    "signon.generation.enabled" = false;
    "signon.management.page.breach-alerts.enabled" = false;
    "browser.tabs.firefox-view" = false;
    "browser.newtabpage.activity-stream.showWeather" = false;
    "browser.newtabpage.activity-stream.feeds.weather" = false;
  };

  searchConfig = {
    force = true;
    default = "google";
    order = [
      "google" "duckduckgo" "youtube" "nixos options"
      "nix packages" "github" "hackernews" "homemanager" "nixvim"
    ];
    engines = {
      "bing".metaData.hidden = true;
      "amazon.com".metaData.hidden = true;

      "nixvim" = {
        icon = "https://github.com/nix-community/nixvim/raw/main/assets/nixvim_logo.svg";
        definedAliases = [ "@v" ];
        urls = [{
          template = "https://nix-community.github.io/nixvim";
          params = [{ name = "search"; value = "{searchTerms}"; }];
        }];
      };
      "youtube" = {
        icon = "https://youtube.com/favicon.ico";
        definedAliases = [ "@yt" ];
        urls = [{
          template = "https://www.youtube.com/results";
          params = [{ name = "search_query"; value = "{searchTerms}"; }];
        }];
      };
      "nix packages" = {
        icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
        definedAliases = [ "@np" ];
        urls = [{
          template = "https://search.nixos.org/packages";
          params = [
            { name = "type"; value = "packages"; }
            { name = "query"; value = "{searchTerms}"; }
          ];
        }];
      };
      "nixos options" = {
        icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
        definedAliases = [ "@no" ];
        urls = [{
          template = "https://search.nixos.org/options";
          params = [
            { name = "channel"; value = "unstable"; }
            { name = "query"; value = "{searchTerms}"; }
          ];
        }];
      };
      "github" = {
        icon = "https://github.com/favicon.ico";
        definedAliases = [ "@gh" ];
        urls = [{
          template = "https://github.com/search";
          params = [{ name = "q"; value = "{searchTerms}"; }];
        }];
      };
      "homemanager" = {
        icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
        definedAliases = [ "@hm" ];
        urls = [{
          template = "https://mipmip.github.io/home-manager-option-search/";
          params = [{ name = "query"; value = "{searchTerms}"; }];
        }];
      };
      "hackernews" = {
        icon = "https://hn.algolia.com/favicon.ico";
        definedAliases = [ "@hn" ];
        urls = [{
          template = "https://hn.algolia.com/";
          params = [{ name = "query"; value = "{searchTerms}"; }];
        }];
      };
    };
  };

  userChromeCSS = ''
  * {
          border-radius: 0 !important;
        }

        .titlebar-close {
            display:none !important;
        }

        .titlebar-spacer[type="pre-tabs"] {
          display: none !important;
        }

        #alltabs-button { display: none !important; }
  '';
in
{
  programs.firefox = {
    enable = true;

    package = pkgs.firefox.overrideAttrs (old: {
      buildCommand =
        old.buildCommand
        + ''
          substituteInPlace $out/bin/firefox \
            --replace "exec -a" ${escapeShellArg envStr}" exec -a"
        '';
    });

    profiles.default = {
      id = 0;
      isDefault = true;
      userChrome = userChromeCSS;
      extraConfig = commonExtraConfig;
      settings = commonSettings;
      search = searchConfig;
    };

    profiles.work = {
      id = 1;
      isDefault = false;
      extraConfig = commonExtraConfig;
      settings = commonSettings // {
        network.proxy.socks = "127.0.0.1";
        network.proxy.socks_port = 3128;
        network.proxy.type = 1;
      };
    };
  };
}
