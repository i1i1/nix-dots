{ pkgs, ... }:
{
  imports = [
    ./dev
    ./dunst.nix
    ./email
    ./firefox.nix
    ./fish.nix
    ./git.nix
    ./i3.nix
    ./kitty.nix
    ./nvim
    ./picom.nix
    ./polybar.nix
    ./telegram.nix
    ./vscodium
    ./zathura.nix
  ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home = rec {
    username = "i1i1";
    homeDirectory = "/home/${username}";

    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    stateVersion = "22.11";

    keyboard = {
      layout = "us,ru";
      options = [ "grp:alt_shift_toggle" "caps:swapescape" ];
    };

    packages = with pkgs;
      let
        terminal_prelude = [
          acpi
          file
          gnupg
          htop
          iotop
          killall
          pkg-config
          trickle
          unrar
          unzip
          usbutils
          wget
          zip
          zlib
        ];
        wm = [
          dmenu
          feh
          jack2
          i3lock
          xorg.xbacklight
        ];
        gui = [
          alacritty
          chromium
          polkit
          libreoffice
          gnome.zenity
          neovide
          discord
          pavucontrol
          pinentry_gtk2
          scrot
        ];
        misc = [
          appimage-run
          sidequest
        ];
        fonts = [
          (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" "Hack" ]; })
        ];
      in
      terminal_prelude ++ wm ++ gui ++ misc ++ fonts;
  };

  # Let Home Manager install and manage itself.
  programs = {
    home-manager.enable = true;
    gpg.enable = true;
    nix-index.enable = true;

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    rbw = {
      enable = true;
      settings.email = "vanyarybin1@live.ru";
    };
  };

  fonts.fontconfig.enable = true;

  services = {
    syncthing.enable = true;
    gpg-agent = {
      enable = true;
      enableSshSupport = true;
    };
  };

  xdg.enable = true;
  xdg.mimeApps.enable = true;

  systemd.user = {
    # TODO
    # services.cargo-sweep = {
    #   Unit.Description = "Remove unnecessarry cargo files";
    #   Service = {
    #     Type = "oneshot";
    #     ExecStart = "zsh -c \"for d in ~/Work/subspace*; do pushd $d; cargo sweep -t 1; popd; done\"";
    #   };
    #   Install.WantedBy = [ "multi-user.target" ];
    # };
    #
    # timers.cargo-sweep-daily = {
    #   Timer.Unit = "cargo-sweep.service";
    #   Timer.OnCalendar = "daily";
    #   Install.WantedBy = [ "timers.target" ];
    # };
  };
}
