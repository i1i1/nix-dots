{ config, pkgs, ... }:
let
  nixvim = import (builtins.fetchGit {
    url = "https://github.com/pta2002/nixvim";
  });
in
{
  imports = [
    nixvim.homeManagerModules.nixvim
  ];

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
        "<C-b>" = {
          action = ":NvimTreeToggle<CR>";
          noremap = true;
          silent = true;
        };

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
      lsp = {
        enable = true;
        servers.rust-analyzer.enable = true;
        servers.rnix-lsp.enable = true;
      };

      nvim-cmp = {
        enable = true;
        sources = [{name = "nvim_lsp";} {name = "luasnip";}];
        mappingPresets = ["insert"];
        mapping = {
          "<CR>" = "cmp.mapping.confirm({ select = true })";
          "<C-k>" = "cmp.mapping.select_prev_item()";
          "<C-j>" = "cmp.mapping.select_next_item()";
        };
        formatting.fields = ["kind" "abbr" "menu"];
      };

      lspkind = {
        enable = true;
        cmp.ellipsisChar = "...";
        cmp.menu = {
          buffer = "[Buffer]";
          nvim_lsp = "[LSP]";
          luasnip = "[LuaSnip]";
          nvim_lua = "[Lua]";
          latex_symbols = "[Latex]";
        };
        cmp.after = ''
          function(entry, vim_item, kind)
            local strings = vim.split(kind.kind, "%s", { trimempty = true })
            kind.kind = " " .. strings[1] .. " "
            kind.menu = "   " .. strings[2]
            return kind
          end
        '';
      };

      nvim-tree = {
        enable = true;
        openOnSetup = true;
        git.enable = true;
      };
      lualine = { enable = true; theme = "ayu_dark"; };

      comment-nvim.enable = true;
      lsp-lines.enable = true;
      nix.enable = true;
      nvim-autopairs.enable = true;
      bufferline.enable = true;
      cmp_luasnip.enable = true;
      luasnip.enable = true;
      telescope.enable = true;
      treesitter.enable = true;
    };
  };
}

