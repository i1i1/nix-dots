{ pkgs, lib, ... }:
let
  mod = "Mod4";
in
{
  xsession = {
    enable = true;
    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;

      config = {
        modifier = mod;

        floating.modifier = mod;

        workspaceLayout = "tabbed";

        modes.resize = {
          "h" = "resize shrink width 40 px or 40 ppt";
          "j" = "resize grow height 40 px or 40 ppt";
          "k" = "resize shrink height 40 px or 40 ppt";
          "l" = "resize grow width 40 px or 40 ppt";

          # back to normal: Enter or Escape or $mod+r
          "Return" = "mode \"default\"";
          "Escape" = "mode \"default\"";
          "${mod}+r" = "mode \"default\"";
        };

        window = {
          hideEdgeBorders = "both";

          commands = [
            {
              command = "move to workspace number 1";
              criteria = { class = "firefox"; };
            }
            {
              command = "move to workspace number 10";
              criteria = { class = "TelegramDesktop"; };
            }
          ];
        };

        keybindings =
          let
            workspace = { name, key }: {
              "${mod}+${key}" = "workspace ${name}";
              "${mod}+Shift+${key}" = "move container to workspace ${name}";
            };
            workspaces = [
              { name = "number 1"; key = "1"; }
              { name = "number 2"; key = "2"; }
              { name = "number 3"; key = "3"; }
              { name = "number 4"; key = "4"; }
              { name = "number 5"; key = "5"; }
              { name = "number 6"; key = "6"; }
              { name = "number 7"; key = "7"; }
              { name = "number 8"; key = "8"; }
              { name = "number 9"; key = "9"; }
              { name = "number 10"; key = "0"; }
            ];
          in
          (lib.lists.fold (a: b: a // b) { } (map workspace workspaces))
          //
          {
            "${mod}+Return" = "exec kitty";
            "${mod}+Shift+q" = "kill";
            "${mod}+d" = "exec --no-startup-id dmenu_run";

            "${mod}+h" = "focus left";
            "${mod}+j" = "focus down";
            "${mod}+k" = "focus up";
            "${mod}+l" = "focus right";

            "${mod}+Shift+h" = "move left";
            "${mod}+Shift+j" = "move down";
            "${mod}+Shift+k" = "move up";
            "${mod}+Shift+l" = "move right";

            "${mod}+s" = "layout stacking";
            "${mod}+w" = "layout tabbed";
            "${mod}+e" = "layout toggle split";

            "${mod}+t" = "split h";
            "${mod}+v" = "split h";
            "${mod}+f" = "fullscreen toggle";
            "${mod}+Shift+space" = "floating toggle";
            "${mod}+space" = "focus mode_toggle";

            "${mod}+Shift+e" = "exec \"i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -B 'Yes, exit i3' 'i3-msg exit'\"";

            "${mod}+r" = "mode \"resize\"";
          };

        startup = [
          {
            command = "feh --bg-fill ~/.background.png";
            always = true;
            notification = false;
          }
          {
            command = "systemctl --user restart polybar.service";
            always = true;
            notification = false;
          }
        ];
      };
    };
  };

  home.file.".background.png".source = ../../assets/background.png;
}
