{
  programs.nixvim = {
    globals = {
      mapleader = " ";

      # Enable filetype matching using fast `filetype.lua`
      do_filetype_lua = 1;

      # Disable useless providers
      loaded_ruby_provider = 0; # Ruby
      loaded_perl_provider = 0; # Perl
      loaded_python_provider = 0; # Python 2
    };

    options = {
      number = true;
      relativenumber = true;

      tabstop = 4;
      shiftwidth = 4;
      expandtab = true;

      laststatus = 3;

      termguicolors = true;

      updatetime = 100; # Faster completion

      splitbelow = true; # A new window is put below the current one
      splitright = true; # A new window is put right of the current one

      swapfile = false; # Disable the swap file

      clipboard = "unnamedplus"; # Use system clipboard

      scrolloff = 8; # Number of screen lines to show around the cursor
      undofile = true; # Automatically save and restore undo history
    };
  };
}
