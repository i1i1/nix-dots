{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home = {
    username = "i1i1";
    homeDirectory = "/home/i1i1";

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
      in
        [
          alacritty
          dmenu
          firefox
          git-crypt
          gnupg
          fzf
          git
          i3lock
          neovim
          polybar
          wget
          xorg.xbacklight
          zsh
          nano
          pinentry_gtk2
          acpi
          llvm
          clang
          mold
          rustup
          tdesktop
          pavucontrol
        ];
  };

  # Let Home Manager install and manage itself.
  programs = {
    home-manager.enable = true;
    gpg.enable = true;
  };

  services = {
    gpg-agent = {
      enable = true;
    };
  };
}
