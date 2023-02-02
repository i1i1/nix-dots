{ pkgs, ... }:
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
        servers = {
          rnix-lsp.enable = true;
          rust-analyzer.enable = true;
        };
        onAttach = ''
          vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.format { async = false }]]
        '';
      };

      nvim-cmp = {
        enable = true;
        sources = [{ name = "nvim_lsp"; } { name = "luasnip"; } { name = "crates"; } { name = "path"; }];
        mappingPresets = [ "insert" ];
        mapping = {
          "<CR>" = "cmp.mapping.confirm({ select = true })";
          "<S-Tab>" = "cmp.mapping.select_prev_item()";
          "<C-k>" = "cmp.mapping.select_prev_item()";
          "<Tab>" = "cmp.mapping.select_next_item()";
          "<C-j>" = "cmp.mapping.select_next_item()";
        };
        formatting.fields = [ "kind" "abbr" "menu" ];
      };

      rust-tools = {
        enable = true;
        reloadWorkspaceFromCargoToml = true;
        inlayHints = {
          auto = true;
          otherHintsPrefix = "  ";
        };
        server = {
          checkOnSave.command = "clippy";
        };
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
      treesitter = {
        enable = true;
        nixGrammars = true;
        ensureInstalled = "all";
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
    };

    extraPlugins = with pkgs.vimPlugins; [
      fidget-nvim
      crates-nvim
    ];
    extraConfigLua = ''
      require"fidget".setup{}
      require"crates".setup{}

      if vim.g.neovide then
        vim.opt.guifont = { "FiraCode", "h14", "#e-subpixelantialias", "#e-antialias", "#h-full" }
        vim.g.neovide_scale_factor = 0.5
      end
    '';

    extraPackages = [ pkgs.xclip ];
  };
}
