{ pkgs, ... }:
{
  programs.nixvim = {
    # A tree like view for symbols in Neovim using the Language Server Protocol. Supports all your favourite languages.
    extraPlugins = [
      pkgs.vimPlugins.symbols-outline-nvim
    ];
    extraConfigLua = ''
      require"symbols-outline".setup{}
    '';

    maps.normal."<C-g>" = ":SymbolsOutline<CR>";
  };
}
