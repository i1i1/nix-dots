{
  programs.nixvim = {
    plugins.telescope.enable = true;

    maps.normal = {
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
}
