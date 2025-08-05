{ config, pkgs, ... }:

{
  programs.firefox = {
    enable = true;

    profiles.default = {
      id = 0;
      isDefault = true;
      extensions.force = true;

      search = {
        default = "google";
        force = true;
        engines = {
          google.metaData.alias = "@g";

          "ChatGPT" = {
            urls = [
              { template = "https://chat.openai.com/search?q={searchTerms}"; }
            ];
            definedAliases = [ "@chatgpt" ];
          };

          "Youtube" = {
            urls = [
              { template = "https://youtube.com/search?q={searchTerms}"; }
            ];
            definedAliases = [ "@yt" ];
            iconMapObj."16" = "https://www.youtube.com/s/desktop/606e092f/img/logos/favicon.ico";
          };

          "Github" = {
            urls = [
              { template = "https://github.com/search?q={searchTerms}"; }
            ];
            definedAliases = [ "@gh" ];
          };

          "NixOS Wiki" = {
            urls = [
              { template = "https://wiki.nixos.org/index.php?search={searchTerms}&title=Special%3ASearch"; }
            ];
            definedAliases = [ "@nw" ];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          };
        };
      };

      settings = {
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "browser.startup.homepage_override.mstone" = "ignore";
        "browser.startup.page" = 3;
        "privacy.donottrackheader.enabled" = true;
        "browser.search.suggest.enabled" = false;
        "toolkit.telemetry.enabled" = false;
        "webgl.disabled" = true;
        "browser.download.always_ask_before_handling_new_types" = true;
        "browser.download.dir" = "${config.xdg.userDirs.download}";
        "browser.urlbar.groupLabels.enabled" = false;
        "browser.urlbar.quicksuggest.enabled" = false;
        "browser.urlbar.speculativeConnect.enabled" = false;
        "browser.urlbar.trimURLs" = false;
        "network.cookie.cookieBehavior" = 1;
        "network.dns.disablePrefetch" = true;
        "network.dns.disablePrefetchFromHTTPS" = true;
        "network.http.referer.spoofSource" = true;
        "network.http.speculative-parallel-limit" = 0;
        "network.predictor.enable-prefetch" = false;
        "network.predictor.enabled" = false;
        "network.prefetch-next" = false;
        "network.trr.mode" = 5;
        "privacy.query_stripping" = true;
        "privacy.trackingprotection.cryptomining.enabled" = true;
        "privacy.trackingprotection.enabled" = true;
        "privacy.trackingprotection.fingerprinting.enabled" = true;
        "privacy.trackingprotection.pbmode.enabled" = true;
        "privacy.usercontext.about_newtab_segregation.enabled" = true;
        "security.ssl.disable_session_identifiers" = true;
        "services.sync.prefs.sync.browser.newtabpage.activity-stream.showSponsoredTopSite" = false;
        "signon.autofillForms" = false;
        "toolkit.telemetry.archive.enabled" = false;
        "toolkit.telemetry.bhrPing.enabled" = false;
        "toolkit.telemetry.cachedClientID" = "";
        "toolkit.telemetry.firstShutdownPing.enabled" = false;
        "toolkit.telemetry.hybridContent.enabled" = false;
        "toolkit.telemetry.newProfilePing.enabled" = false;
        "toolkit.telemetry.prompted" = 2;
        "toolkit.telemetry.rejected" = true;
        "toolkit.telemetry.reportingpolicy.firstRun" = false;
        "toolkit.telemetry.server" = "";
        "toolkit.telemetry.shutdownPingSender.enabled" = false;
        "toolkit.telemetry.unified" = false;
        "toolkit.telemetry.unifiedIsOptIn" = false;
        "toolkit.telemetry.updatePing.enabled" = false;
        "browser.download.useDownloadDir" = true;
        "browser.download.folderList" = 2;
      };

      userChrome = ''
        #firefox-view-button,
        #alltabs-button,
        .titlebar-close,
        .tab-close-button,
        #tracking-protection-icon-container,
        .bookmark-item .toolbarbutton-icon {
          display: none !important;
        }

        :root {
          --conf-border-radius: 24px;
          --conf-toolbar-border-radius: 24px;
          --toolbarbutton-border-radius: var(--conf-toolbar-border-radius) !important;
          --tab-border-radius: var(--conf-border-radius) !important;
          --transition: 0.25s ease-in-out;
        }

        .tab-label {
          padding-left: 5px;
          padding-right: 5px;
          border-radius: var(--conf-border-radius) !important;
          font-size: 14px;
        }

        @media (prefers-color-scheme: dark) {
          .tab-label {
            border-radius: var(--conf-toolbar-border-radius) !important;
          }
        }

        .titlebar-spacer {
          display: none;
        }

        .bookmark-item {
          margin-right: 10px !important;
        }

        .tabbrowser-tab[selected="true"], .tabbrowser-tab[selected="true"] > * {
          font-weight: bold !important;
        }
      '';
    };

    policies = {
      ExtensionSettings = {
        "return-youtube-dislike@anarios.github.com" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/return-youtube-dislikes/latest.xpi";
          installation_mode = "force_installed";
        };

        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
        };

        "jid1-BoFifL9Vbdl2zQ@jetpack" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/decentraleyes/latest.xpi";
          installation_mode = "force_installed";
        };

        "{72bd91c9-3dc5-40a8-9b10-dec633c0873f}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/enhanced-github/latest.xpi";
          installation_mode = "force_installed";
        };

        "{a4c4eda4-fb84-4a84-b4a1-f7c1cb2a1ad}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/refined-github-/latest.xpi";
          installation_mode = "force_installed";
        };
      };
    };
  };
}
