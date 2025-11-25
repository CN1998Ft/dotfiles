-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.winbar = "%=%m %F"
-- Set minimal number of screen lines above and below the cursor
vim.opt.scrolloff = 10 -- Keeps at least 10 lines above/below cursor
vim.opt.sidescrolloff = 900 --Keep at least 5 col on the left.

-- Tab settings: expand tab to spaces, and set width to 4
vim.opt.expandtab = true -- Convert tabs to spaces
vim.opt.tabstop = 2 -- Number of spaces a tab counts for
vim.opt.shiftwidth = 2 -- Number of spaces to use for autoindent
vim.opt.softtabstop = 2 -- Number of spaces a tab counts for while editing

-- Set cursor to blink during nvim.
vim.opt.guicursor = {
  "n-v-c:block-blinkon500-blinkoff500",
  "i-ci:ver25-blinkon500-blinkoff500",
  "r-cr:hor20-blinkon500-blinkoff500",
  "o:hor40-blinkon500-blinkoff500",
}

-- Add column ruler at 80.
vim.opt.colorcolumn = "80"

-- Line number and relative number
vim.opt.number = true
vim.opt.relativenumber = true
