{ pkgs, ... }: {
  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    enableNushellIntegration = true;
    pinentryPackage = pkgs.pinentry-qt;  # Use pinentry-qt for Qt-based dialog
  };
}
