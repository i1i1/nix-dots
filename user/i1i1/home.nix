{ pkgs, ... }:
let
  homeDirectory = "/home/i1i1";
in
{
  imports = [
    ./nvim.nix
    ./git.nix
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
        polybar = pkgs.polybar.override {
          i3Support = true;
        };
        firefox = callPackage ./firefox.nix { };
      in
      [
        acpi
        alacritty
        bat
        chromium
        dmenu
        feh
        file
        firefox
        git-crypt
        gnupg
        htop
        i3lock
        killall
        ltrace
        nano
        pavucontrol
        pinentry_gtk2
        polybar
        ripgrep
        scrot
        strace
        tdesktop
        usbutils
        wget
        # rustup
        # cargo-sweep
        xorg.xbacklight
        zlib
      ];
  };

  # Let Home Manager install and manage itself.
  programs = {
    home-manager.enable = true;
    gpg.enable = true;
    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };

    fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    zsh = {
      enable = true;

      shellAliases = {
        ca = "cargo";
        g = "git";
        n = "nv";
        nv = "nvim";
      };

      oh-my-zsh = {
        enable = true;
        theme = "eastwood";
        plugins = [ "git" "gitfast" "fzf" "docker" "rust" "ripgrep" ];
      };

      initExtra = ''
        chhm() {
            pushd ~/.dotfiles/user/i1i1/
            $EDITOR home.nix
            home-manager switch -f home.nix
            popd
        }
        chnix() {
            pushd ~/.dotfiles/system
            $EDITOR configuration.nix
            apply-configuration
            popd
        }

        source $HOME/.cargo/env
        export PATH=$HOME/.local/bin:$HOME/.dotfiles:$PATH
      '';
    };
  };

  services = {
    gpg-agent.enable = true;
  };

  systemd.user = {
    sessionVariables = {
      EDITOR = "nvim";
      CARGO_TARGET_DIR = "${homeDirectory}/.cargo-target";
    };

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
