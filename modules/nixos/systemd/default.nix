{ pkgs, ... }:

{
  # Existing polkit user service
  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    description = "polkit-gnome-authentication-agent-1";
    wantedBy = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };

  # Home Manager user service with backup script
  systemd.user.services.home-manager-wug = {
    description = "Home Manager environment for wug with backup";
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.bash}/bin/bash -c ''
        set -e

        FILES=(
          \"$HOME/.config/fish/config.fish\"
          \"$HOME/.config/ghostty/config\"
          \"$HOME/.config/mimeapps.list\"
          \"$HOME/.config/user-dirs.dirs\"
        )

        # Backup existing files
        for f in \"\${FILES[@]}\"; do
          if [ -f \"\$f\" ]; then
            mv \"\$f\" \"\$f.bak\"
          fi
        done

        # Activate Home Manager
        ${pkgs.home-manager}/bin/hm-activate wug
      ''";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };

  # udev packages
  services.udev = {
    packages = with pkgs; [
      qmk
      qmk-udev-rules
      qmk_hid
      via
      vial
    ];
  };
}
