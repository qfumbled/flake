{
  programs.alacritty = {
    enable = true;

    colors = {
      primary = {
        background = "#f5f3ef"; # base00
        foreground = "#5c5c5c"; # base05
      };

      normal = {
        black = "#5c5c5c"; # base06
        red = "#b66467"; # base08
        green = "#76b05c"; # base0B
        yellow = "#b88757"; # base09 / base0A
        blue = "#66858f"; # base0D
        magenta = "#9661cc"; # base0E
        cyan = "#7d9ea7"; # base0C
        white = "#999898"; # base04
      };

      bright = {
        black = "#b3b2b1"; # base03
        red = "#b66467"; # base08
        green = "#76b05c"; # base0B
        yellow = "#b88757"; # base09 / base0A
        blue = "#66858f"; # base0D
        magenta = "#9661cc"; # base0E
        cyan = "#7d9ea7"; # base0C
        white = "#5c5c5c"; # base07
      };
    };
  };
}
