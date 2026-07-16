vim.pack.add({
  "https://github.com/lervag/vimtex",
  "https://github.com/MeanderingProgrammer/render-markdown.nvim",
})
if vim.fn.has("win32") == 1 then
  vim.g.vimtex_view_general_viewer = "okular"
elseif vim.fn.has("mac") == 1 then
  vim.g.vimtex_view_general_viewer = "/Applications/okular.app/Contents/MacOS/okular"
end
vim.g.vimtex_view_general_options = "file:@pdf#src:@line@tex"
require("render-markdown").setup({
  enabled = false,
})
