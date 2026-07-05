-- Options for nvim
vim.opt.number = true
-- vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 10
vim.opt.signcolumn = "auto:1"
vim.opt.conceallevel = 0
vim.opt.concealcursor = ""
vim.opt.swapfile = false

-- Tab settings:
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

-- Highlight group
vim.api.nvim_set_hl(0, "MiniTrailspace", { bg = "#e67e80", fg = "NONE", underline = false, undercurl = false })
vim.api.nvim_set_hl(0, "HighlightWhitespaces", { bg = "#d699b6", fg = "NONE", underline = false, undercurl = false })
vim.api.nvim_set_hl(0, "NormalCursor", { fg = "#000000", bg = "#71b7ff" })
vim.api.nvim_set_hl(0, "InsertCursor", { fg = "#000000", bg = "#26cd4d" }) -- cyan
vim.api.nvim_set_hl(0, "VisualCursor", { fg = "#000000", bg = "#cb9eff" }) -- Magenta
vim.api.nvim_set_hl(0, "ReplaceCursor", { fg = "#000000", bg = "#ff9492" }) -- red

-- Cursor
vim.opt.termguicolors = true
vim.opt.guicursor = {
  "n-c-t:block-NormalCursor",
  "i-ci:ver25-InsertCursor",
  "v:block-VisualCursor",
  "r-cr:hor10-ReplaceCursor",
}
vim.opt.cursorline = true

-- Add column ruler at 80
vim.opt.colorcolumn = "80"

-- fold
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevel = 99

-- Miscellaneous
vim.opt.ruler = false
vim.opt.showmode = false
vim.opt.splitbelow = true
vim.opt.splitright = true

if vim.fn.has("mac") == 1 and vim.env.TERM_PROGRAM == "ghostty" then
  vim.o.shell = "/bin/zsh"
elseif vim.fn.has("mac") == 1 and vim.env.ALACRITTY_LOG ~= nil then
  vim.o.shell = "/opt/homebrew/bin/bash"
elseif vim.fn.has("Linux") == 1 then
  vim.o.shell = "/usr/bin/bash"
end

-- Undodir and undofile
local undodir = vim.fn.stdpath("data") .. "/undo"

if vim.fn.isdirectory(undodir) == 0 then
  vim.fn.mkdir(undodir, "p")
end

vim.opt.undodir = undodir
vim.opt.undofile = true

-- neovide config
if vim.g.neovide then
  vim.o.guifont = "JetBrainsMonoNL Nerd Font:h13"
  vim.g.neovide_cursor_vfx_particle_lifetime = 0.2
  vim.g.neovide_cursor_trail_size = 0.1
  vim.g.neovide_cursor_animation_length = 0.05
  vim.g.neovide_cursor_short_animation_length = 0.05
end
