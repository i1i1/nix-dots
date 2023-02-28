{
  programs.nixvim = {
    maps.normal."<C-b>" = ":NvimTreeToggle<CR>";

    plugins.nvim-tree = {
      enable = true;

      autoClose = true;

      diagnostics = {
        enable = true;

        icons = {
          hint = "";
          info = "";
          warning = "";
          error = "";
        };
      };
      git.enable = true;

      updateFocusedFile.enable = true;

      filters = {
        dotfiles = true;
        custom = [
          ".git"
          "node_modules"
          ".cache"
          "__pycache__"
          "*.aux"
          "*.bbl"
          "*.blg"
          "*.egg-info"
          "*.fdb_latexmk"
          "*.fls"
          "*.maf"
          "*.mtc"
          "*.mtc0"
          "*.pyc"
          "*.run.xml"
          "*.synctex*"
        ];
      };
    };
  };
}
