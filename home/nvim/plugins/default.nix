{
  imports = [
    ./telescope.nix
    ./treesitter.nix
    ./nvim-tree.nix
    ./lsp
  ];

  programs.nixvim = {
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
  };
}
