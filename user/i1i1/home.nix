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
          acpi
          alacritty
          dmenu
          firefox
          fzf
          git
          git-crypt
          gnupg
          i3lock
          nano
          pavucontrol
          pinentry_gtk2
          polybar
	  htop
          tdesktop
          wget
          xorg.xbacklight
          zsh
        ];
  };

  # Let Home Manager install and manage itself.
  programs = {
    home-manager.enable = true;
    gpg.enable = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    nixvim = {
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
  };

  services = {
    gpg-agent = {
      enable = true;
    };
  };
}
