{
  programs.nixvim.extraConfigLua = ''
    if vim.g.neovide then
      vim.opt.guifont = { "FiraCode", "h14", "#e-subpixelantialias", "#e-antialias", "#h-full" }
      vim.g.neovide_scale_factor = 0.5
    end
  '';
}
