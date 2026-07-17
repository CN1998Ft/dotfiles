vim.pack.add({
  "https://github.com/neanias/everforest-nvim",
  "https://github.com/projekt0n/github-nvim-theme",
})
require("everforest").setup({
  background = "hard",
  transparent_background_level = 0,
  ui_contrast = "high",
})
vim.cmd([[colorscheme github_dark_high_contrast]])
-- require("everforest").load()
