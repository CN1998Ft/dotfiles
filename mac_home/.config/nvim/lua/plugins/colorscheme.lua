vim.pack.add({ "https://github.com/neanias/everforest-nvim" })
require("everforest").setup({
  background = "hard",
  transparent_background_level = 0,
  ui_contrast = "high",
})
require("everforest").load()
