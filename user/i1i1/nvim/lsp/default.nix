{ pkgs, ... }:
{
  imports = [ ./rust.nix ./completion.nix ./symbols-outline.nix ];

  programs.nixvim = {
    maps.normal = {
      "gd" = "vim.lsp.buf.definition";
      "gD" = "vim.lsp.buf.references";
      "gt" = "vim.lsp.buf.type_definition";
      "gi" = "vim.lsp.buf.implementation";
      "K" = "vim.lsp.buf.hover";

      # Navigate in diagnostics
      "<leader>k" = "vim.diagnostic.goto_prev";
      "<leader>j" = "vim.diagnostic.goto_next";

      # Rename
      "<F2>" = "vim.lsp.buf.rename";
    };

    plugins = {
      lsp = {
        enable = true;
        servers.rnix-lsp.enable = true;
        # Autoformat
        onAttach = ''
          vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.format { async = false }]]
        '';
      };

      # vscode-like pictograms
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

      # renders diagnostics using virtual lines
      lsp-lines.enable = true;

    };

    # UI for nvim-lsp progress (for example rust-analyzer compilation progress)
    extraPlugins = [ pkgs.vimPlugins.fidget-nvim ];
    extraConfigLua = ''
      require"fidget".setup{}
    '';
  };
}
