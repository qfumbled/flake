{ pkgs, ... }: {
  systemd.user.services.polkit-kde-agent-1 = {
    Unit.Description = "polkit-kde-agent-1";

    Install = {
      WantedBy = ["graphical-session.target"];
      Wants = ["graphical-session.target"];
      After = ["graphical-session.target"];
    };

    Service = {
      Type = "simple";
      ExecStart = "${pkgs.kdePackages.polkit-kde-agent-1}/bin/polkit-kde-authentication-agent-1";  # Use Qt 6 version
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };
}
