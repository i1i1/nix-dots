{ pkgs, ... }: {
  programs.nixvim.plugins = {
    lsp.servers.rust-analyzer.enable = true;
    rust-tools = {
      enable = true;
      reloadWorkspaceFromCargoToml = true;
      inlayHints = {
        auto = true;
        otherHintsPrefix = "  ";
      };
      server = { checkOnSave.command = "clippy"; };
    };
  };

  programs.nixvim.extraPlugins = [ pkgs.vimPlugins.crates-nvim ];
  programs.nixvim.extraConfigLua = ''
    require"crates".setup{}
  '';
}
