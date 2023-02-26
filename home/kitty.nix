{ pkgs, ... }: {
  home.sessionVariables.TERMINAL = "kitty";
  systemd.user.sessionVariables.TERMINAL = "kitty";

  programs.kitty = {
    enable = true;
    font.name = "FiraCode";
    font.size = 15;
    settings = {
      italic_font = "auto";
      bold_italic_font = "auto";
      mouse_hide_wait = 2;
      cursor_shape = "block";
      url_color = "#0087bd";
      url_style = "dotted";
      #Close the terminal =  without confirmation;
      confirm_os_window_close = 0;
      background_opacity = "0.95";
    };
    extraConfig = ''
      background            #001e26
      foreground            #708183
      cursor                #708183
      selection_background  #002731
      color0                #002731
      color8                #465a61
      color1                #d01b24
      color9                #bd3612
      color2                #728905
      color10               #465a61
      color3                #a57705
      color11               #52676f
      color4                #2075c7
      color12               #708183
      color5                #c61b6e
      color13               #5856b9
      color6                #259185
      color14               #81908f
      color7                #e9e2cb
      color15               #fcf4dc
      selection_foreground  #001e26
    '';
  };
}
