{ pkgs, ... }:
{
  services.dunst = {
    enable = true;
    settings = {
      global = {
        font = "FiraCode 16";
        markup = "yes";
        plain_text = "no";

        format = ''
          %a
          <b>%s</b>
          %b'';

        sort = "yes";

        indicate_hidden = "yes";

        alignment = "center";

        bounce_freq = 0;

        word_wrap = "yes";

        ignore_newline = "no";

        stack_duplicates = "yes";
        hide_duplicates_count = "no";

        geometry = "500x10-0+0";

        shrink = "no";

        idle_threshold = 0;

        transparency = 5;

        follow = "none";

        sticky_history = "yes";

        history_length = 15;

        show_indicators = "no";

        line_height = 3;
        separator_height = 1;
        padding = 1;
        horizontal_padding = 1;

        separator_color = "frame";

        startup_notification = true;

        dmenu = "${pkgs.dmenu}/bin/dmenu -p dunst:";

        icon_position = "off";
        max_icon_size = 80;

        frame_width = 2;
        frame_color = "#8EC07C";

      };

      urgency_low = {
        frame_color = "#268bd2";
        foreground = "#002b36";
        background = "#fdf6e3";
        #timeout = 1;
      };

      urgency_normal = {
        frame_color = "#b58900";
        foreground = "#002b36";
        background = "#fdf6e3";
        #timeout = 1;
      };

      urgency_critical = {
        frame_color = "#dc322f";
        foreground = "#002b36";
        background = "#fdf6e3";
        #timeout = 1;
      };
    };
  };
}
