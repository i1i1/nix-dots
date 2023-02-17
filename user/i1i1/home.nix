{ pkgs, ... }:
let
  homeDirectory = "/home/i1i1";
in
{
  imports = [
    ./nvim.nix
    ./fish.nix
    ./kitty.nix
    ./polybar.nix
    ./git.nix
    ./i3.nix
  ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home = {
    username = "i1i1";
    homeDirectory = homeDirectory;

    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    stateVersion = "22.11";

    packages = with pkgs;
      let
        firefox = callPackage ./firefox.nix { };
      in
      [
        # cargo-sweep
        rustup
        acpi
        alacritty
        bat
        chromium
        dmenu
        exa
        feh
        file
        firefox
        git
        git-crypt
        gnupg
        htop
        i3lock
        killall
        ltrace
        nano
        neovide
        pavucontrol
        pinentry_gtk2
        python311
        ripgrep
        scrot
        strace
        tdesktop
        unzip
        usbutils
        wget
        xorg.xbacklight
        zlib
        (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" "Hack" ]; })
      ];
  };

  # Let Home Manager install and manage itself.
  programs = {
    home-manager.enable = true;
    gpg.enable = true;
    fzf.enable = true;

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };

  fonts.fontconfig.enable = true;

  services = {
    gpg-agent = {
      enable = true;
      enableSshSupport = true;
    };
  };

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
