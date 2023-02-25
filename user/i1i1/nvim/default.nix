{ pkgs, ... }:

let
  codeium = pkgs.vimUtils.buildVimPluginFrom2Nix {
    name = "codeium";
    src = pkgs.fetchFromGitHub {
      owner = "Exafunction";
      repo = "codeium.vim";
      rev = "88a6a07080301858b0bd02d04f18aa33c96e353c";
      hash = "sha256-PNNzdMbMImqh0qe2duQX/GF2MzJIGTUtbN5gKVCwJ70=";
    };
  };
in
{
  imports = [
    ./autocommands.nix
    ./lsp
    ./neovide.nix
    ./nvim-tree.nix
    ./options.nix
    ./telescope.nix
    ./treesitter.nix
  ];

  home.sessionVariables.EDITOR = "nvim";
  systemd.user.sessionVariables.EDITOR = "nvim";

  programs.nixvim = {
    enable = true;
    colorschemes.onedark.enable = true;
    globals.mapleader = " ";

    plugins = {
      lualine = {
        enable = true;
        theme = "ayu_dark";
      };

      comment-nvim.enable = true;
      nix.enable = true;
      nvim-autopairs.enable = true;
      bufferline.enable = true;
      luasnip.enable = true;
    };

    # extraPlugins = [ codeium ];
    extraPackages = [ pkgs.xclip ];
  };
}
