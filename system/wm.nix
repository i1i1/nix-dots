{ config, pkgs, ... }:
{
  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    layout = "us,ru";
    xkbOptions = "grp:alt_shift_toggle, caps:swapescape";
    dpi = 130;

    libinput.enable = true;

    #desktopManager.xterm.enable = false;
    displayManager.defaultSession = "none+i3";
    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs;
        let
          polybar = pkgs.polybar.override {
            i3Support = true;
          };
        in
        [
          dmenu
          i3lock
          polybar
        ];
    };
  };

  hardware.pulseaudio.enable = true;
  programs.dconf.enable = true;

  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
  ];
}
