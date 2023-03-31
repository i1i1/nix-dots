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
      server = {
        checkOnSave = true;
        check.overrideCommand = [
          "cargo"
          "clippy"
          "--workspace"
          "--message-format=json"
          "--all-targets"
        ];
      };
    };
  };

  programs.nixvim.extraPlugins = [ pkgs.vimPlugins.crates-nvim ];
  programs.nixvim.extraConfigLua = ''
    require"crates".setup{}
  '';
}
