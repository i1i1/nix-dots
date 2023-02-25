{
  programs.nixvim = {
    options.completeopt = [ "menu" "menuone" "noselect" ];

    plugins.nvim-cmp = {
      enable = true;
      sources =
        let source = source: { name = source; };
        in map source [ "nvim_lsp" "codeium" "luasnip" "crates" "path" ];

      mapping = {
        "<CR>" = "cmp.mapping.confirm({ select = true })";
        "<S-Tab>" = {
          modes = [ "i" "s" ];
          action = "cmp.mapping.select_prev_item()";
        };
        "<C-k>" = "cmp.mapping.select_prev_item()";
        "<Tab>" = {
          modes = [ "i" "s" ];
          action = "cmp.mapping.select_next_item()";
        };
        "<C-j>" = "cmp.mapping.select_next_item()";
      };
    };

    # Lua snip integration for nvim-cmp
    plugins.cmp_luasnip.enable = true;
  };
}
