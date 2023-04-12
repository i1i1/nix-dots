{ pkgs, ... }:
{
  imports = [
    ./nvim
    ./fish.nix
    ./rust.nix
    ./kitty.nix
    ./polybar.nix
    ./git.nix
    ./i3.nix
    ./picom.nix
    ./firefox.nix
    ./telegram.nix
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
        terminal = [
          trickle
          acpi
          file
          gnupg
          htop
          iotop
          jq
          killall
          ltrace
          openssl
          pup
          strace
          unzip
          zip
          usbutils
          wget
          zlib
        ];
        wm = [
          dmenu
          feh
          i3lock
          xorg.xbacklight
        ];
        gui = [
          alacritty
          chromium
          polkit
          libreoffice
          neovide
          discord
          pavucontrol
          pinentry_gtk2
          scrot
        ];
        dev = [
          opencl-headers
          opencl-clhpp
          ocl-icd
          (python3.withPackages (p: with p; [ pygame ]))
        ];
        misc = [
          appimage-run
          sidequest
        ];
        fonts = [
          (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" "Hack" ]; })
        ];
      in
      terminal ++ wm ++ gui ++ dev ++ misc ++ fonts;
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
