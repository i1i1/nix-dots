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
  imports = [ ./nvim-tree.nix ./lsp ];

  home.sessionVariables.EDITOR = "nvim";
  systemd.user.sessionVariables.EDITOR = "nvim";

  programs.nixvim = {
    enable = true;
    colorschemes.onedark.enable = true;
    globals.mapleader = " ";

    options = {
      number = true;
      relativenumber = true;

      tabstop = 4;
      shiftwidth = 4;
      expandtab = true;

      laststatus = 3;

      termguicolors = true;
    };

    maps = {
      normal = {
        "<leader>ff" = {
          action = ''<cmd>lua require("telescope.builtin").find_files()<CR>'';
          noremap = true;
        };
        "<leader>fg" = {
          action = ''<cmd>lua require("telescope.builtin").live_grep()<CR>'';
          noremap = true;
        };
        "<leader>fb" = {
          action = ''<cmd>lua require("telescope.builtin").buffers()<CR>'';
          noremap = true;
        };
        "<leader>fh" = {
          action = ''<cmd>lua require("telescope.builtin").help_tags()<CR>'';
          noremap = true;
        };
      };
    };

    plugins = {
      treesitter = {
        enable = true;
        nixGrammars = true;
        ensureInstalled = "all";
      };

      lualine = {
        enable = true;
        theme = "ayu_dark";
      };

      comment-nvim.enable = true;
      nix.enable = true;
      nvim-autopairs.enable = true;
      bufferline.enable = true;
      luasnip.enable = true;
      telescope.enable = true;
    };

    # extraPlugins = [ codeium ];
    extraConfigLua = ''
      if vim.g.neovide then
        vim.opt.guifont = { "FiraCode", "h14", "#e-subpixelantialias", "#e-antialias", "#h-full" }
        vim.g.neovide_scale_factor = 0.5
      end
    '';

    extraPackages = [ pkgs.xclip ];
  };
}
