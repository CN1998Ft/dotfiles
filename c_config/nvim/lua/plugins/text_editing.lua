vim.pack.add({
  "https://github.com/lervag/vimtex",
  "https://github.com/MeanderingProgrammer/render-markdown.nvim",
})
vim.g.vimtex_view_general_viewer = "okular"
vim.g.vimtex_view_general_options = "--unique file:@pdf#src:@line@tex"
require("render-markdown").setup({
  enabled = false,
})
