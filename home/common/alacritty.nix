{
  programs.alacritty = {
    enable = true;
    config = ''
      window:
        padding:
          x: 2
          y: 2
      colors:
        primary:
          background: '#f5f3ef'
          foreground: '#5c5c5c'

        normal:
          black:   '#5c5c5c'
          red:     '#b66467'
          green:   '#76b05c'
          yellow:  '#b88757'
          blue:    '#66858f'
          magenta: '#9661cc'
          cyan:    '#7d9ea7'
          white:   '#999898'

        bright:
          black:   '#b3b2b1'
          red:     '#b66467'
          green:   '#76b05c'
          yellow:  '#b88757'
          blue:    '#66858f'
          magenta: '#9661cc'
          cyan:    '#7d9ea7'
          white:   '#5c5c5c'
    '';
  };
}
