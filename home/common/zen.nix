{
  programs.zen-browser.policies = {
    AutofillAddressEnabled = true;
    AutofillCreditCardEnabled = false;
    DisableAppUpdate = true;
    DisableFeedbackCommands = true;
    DisableFirefoxStudies = true;
    DisablePocket = true;
    DisableTelemetry = true;
    DontCheckDefaultBrowser = true;
    NoDefaultBookmarks = true;
    OfferToSaveLogins = false;

    EnableTrackingProtection = {
      Value = true;
      Locked = true;
      Cryptomining = true;
      Fingerprinting = true;
    };

    Preferences = {
      "browser.tabs.warnOnClose" = {
        Value = false;
        Status = "locked";
      };
      # Add more preferences here as needed
    };

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
}
