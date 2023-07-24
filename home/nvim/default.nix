{ pkgs, ... }:
{
  imports = [
    ./autocommands.nix
    ./plugins
    ./neovide.nix
    ./options.nix
  ];

  home.sessionVariables.EDITOR = "nvim";
  systemd.user.sessionVariables.EDITOR = "nvim";

  programs.nixvim = {
    enable = true;
    colorschemes.onedark.enable = true;
    globals.mapleader = " ";

    extraPackages = [ pkgs.xclip ];
  };
}
