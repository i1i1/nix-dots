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
  imports = [ ./autocommands.nix ./nvim-tree.nix ./options.nix ./neovide.nix ./lsp ];

  home.sessionVariables.EDITOR = "nvim";
  systemd.user.sessionVariables.EDITOR = "nvim";

  programs.nixvim = {
    enable = true;
    colorschemes.onedark.enable = true;
    globals.mapleader = " ";

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
    extraPackages = [ pkgs.xclip ];
  };
}
