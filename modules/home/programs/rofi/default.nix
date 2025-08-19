{ config, pkgs, lib, ... }:

let
  colors = config.lib.stylix.colors;
in
{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    # font = "Iosevka Nerd Font";
    extraConfig = {
      modi = "drun";
      display-drun = "";
      show-icons = true;
      drun-display-format = "{name}";
      sidebar-mode = false;
    };
  };

  xdg = {
    configFile."rofi/config.rasi".text = ''
      /**
       * Rofi Theme File
       * Author : Aditya Shakya (adi1090x)
       * Rofi Version: 1.7.3
       **/

      /*****----- Configuration -----*****/
      configuration {
        modi:                       "drun,run,filebrowser,window";
        show-icons:                 false;
        display-drun:               " ";
        display-run:                " ";
        display-filebrowser:        " ";
        display-window:             " ";
        drun-display-format:        "{name}";
        window-format:              "{w} · {c} · {t}";
      }

      /*****----- Global Properties -----*****/
      * {
        border-colour:               var(selected);
        handle-colour:               var(selected);
        background-colour:           var(background);
        foreground-colour:           var(foreground);
        alternate-background:        var(background-alt);
        normal-background:           var(background);
        normal-foreground:           var(foreground);
        urgent-background:           var(urgent);
        urgent-foreground:           var(background);
        active-background:           var(active);
        active-foreground:           var(background);
        selected-normal-background:  var(selected);
        selected-normal-foreground:  var(background);
        selected-urgent-background:  var(active);
        selected-urgent-foreground:  var(background);
        selected-active-background:  var(urgent);
        selected-active-foreground:  var(background);
        alternate-normal-background: var(background);
        alternate-normal-foreground: var(foreground);
        alternate-urgent-background: var(urgent);
        alternate-urgent-foreground: var(background);
        alternate-active-background: var(active);
        alternate-active-foreground: var(background);
      }

      /*****----- Main Window -----*****/
      window {
        transparency:                "real";
        location:                    center;
        anchor:                      center;
        fullscreen:                  false;
        width:                       400px;
        x-offset:                    0px;
        y-offset:                    0px;
        enabled:                     true;
        margin:                      0px;
        padding:                     0px;
        border:                      0px solid;
        border-radius:               10px;
        border-color:                #89B4FA;
        cursor:                      "default";
        background-color:            var(background);
      }

      /*****----- Main Box -----*****/
      mainbox {
        enabled:                     true;
        spacing:                     10px;
        margin:                      0px;
        padding:                     30px;
        border:                      0px solid;
        border-radius:               15px;
        border-color:                #6f91c9;
        background-color:            transparent;
        transparency:                "real";
        children:                    [ "inputbar", "message", "listview" ];
      }

      /*****----- Inputbar -----*****/
      inputbar {
        enabled:                     true;
        spacing:                     10px;
        margin:                      0px;
        padding:                     0px;
        border:                      0px solid;
        border-radius:               0px;
        border-color:                var(border);
        background-color:            transparent;
        text-color:                  var(foreground);
        children:                    [ "textbox-prompt-colon", "entry", "mode-switcher" ];
      }

      prompt {
        enabled:                     true;
        background-color:            inherit;
        text-color:                  inherit;
      }

      textbox-prompt-colon {
        enabled:                     true;
        padding:                     5px 0px;
        expand:                      false;
        str:                         "";
        background-color:            inherit;
        text-color:                  inherit;
      }

      entry {
        enabled:                     true;
        padding:                     5px 0px;
        background-color:            inherit;
        text-color:                  inherit;
        cursor:                      text;
        placeholder:                 "Search...";
        placeholder-color:           inherit;
      }

      num-filtered-rows, textbox-num-sep, num-rows, case-indicator {
        enabled: true;
        background-color: var(background);
        text-color: var(foreground);
      }

      /*****----- Listview -----*****/
      listview {
        enabled:                     true;
        columns:                     1;
        lines:                       8;
        cycle:                       true;
        dynamic:                     true;
        scrollbar:                   true;
        layout:                      vertical;
        reverse:                     false;
        fixed-height:                true;
        fixed-columns:               true;
        spacing:                     5px;
        margin:                      0px;
        padding:                     0px;
        border:                      0px solid;
        border-radius:               0px;
        border-color:                var(border);
        background-color:            transparent;
        text-color:                  var(foreground);
        cursor:                      "default";
      }

      scrollbar {
        handle-width:                3px ;
        handle-color:                var(handle);
        border-radius:               10px;
        background-color:            var(background-alt);
      }

      /*****----- Elements -----*****/
      element {
        enabled: true;
        spacing: 10px;
        margin: 0px;
        padding: 5px 10px;
        border: 0px solid;
        border-radius: 10px;
        border-color: var(border);
        background-color: transparent;
        text-color: var(foreground);
        cursor: pointer;
      }

      element normal.normal {
        background-color: var(normal-background);
        text-color: var(normal-foreground);
      }
      element normal.urgent {
        background-color: var(urgent-background);
        text-color: var(urgent-foreground);
      }
      element normal.active {
        background-color: var(active-background);
        text-color: var(active-foreground);
      }
      element selected.normal {
        background-color: var(selected-normal-background);
        text-color: var(selected-normal-foreground);
      }
      element selected.urgent {
        background-color: var(selected-urgent-background);
        text-color: var(selected-urgent-foreground);
      }
      element selected.active {
        background-color: var(selected-active-background);
        text-color: var(selected-active-foreground);
      }

      /*****----- Mode Switcher -----*****/
      mode-switcher {
        enabled: true;
        spacing: 10px;
        margin: 0px;
        padding: 0px;
        border: 0px solid;
        border-radius: 0px;
        border-color: var(border);
        background-color: transparent;
        text-color: var(foreground);
      }

      /*****----- Buttons & Message -----*****/
      button {
        padding: 5px 10px;
        border: 0px solid;
        border-radius: 10px;
        border-color: var(border);
        background-color: var(background-alt);
        text-color: inherit;
        cursor: pointer;
      }

      button selected {
        background-color: var(selected-normal-background);
        text-color: var(selected-normal-foreground);
      }

      message {
        enabled: true;
        margin: 0px;
        padding: 0px;
        border: 0px solid;
        border-radius: 0px;
        border-color: var(border);
        background-color: transparent;
        text-color: var(foreground);
      }

      textbox {
        padding: 8px 10px;
        border: 0px solid;
        border-radius: 10px;
        border-color: var(border);
        background-color: var(background-alt);
        text-color: var(foreground);
        vertical-align: 0.5;
        horizontal-align: 0.0;
        highlight: none;
        placeholder-color: var(foreground);
        blink: true;
        markup: true;
      }

      error-message {
        padding: 10px;
        border: 2px solid;
        border-radius: 10px;
        border-color: var(border);
        background-color: var(background);
        text-color: var(foreground);
      }
    '';

    configFile."rofi/colors.rasi".text = ''
      * {
        background:     #${colors.base00};
        background-alt: #${colors.base01};
        foreground:     #${colors.base05};
        selected:       #${colors.base08};
        active:         #${colors.base04};
        urgent:         #${colors.base03};
      }
    '';
  };
}
