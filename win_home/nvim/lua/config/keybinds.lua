-- For compatible reasons, the icons and group is defined inside the
-- plugins/whsichkey.lua
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>e", vim.cmd.Ex, {desc = "Explorer"})
vim.keymap.set("n", "<leader>t", ':below term<CR> | :resize 15<CR>', {desc = "Open terminal below"})

-- buffers
vim.keymap.set("n", "<leader>bd", ":bd<CR>", {desc = "Delete the current buffer"})
vim.keymap.set("n", "<leader>bb", ":Pick buffers<CR>", {desc = "mini.pick buffers"})
vim.keymap.set("n", "<leader>bp", ":bp<CR>", {desc = "Previous buffer"})
vim.keymap.set("n", "<leader>bn", ":bn<CR>", {desc = "Next buffer"})

-- mini.diff
vim.keymap.set("n", "<leader>o", ":lua MiniDiff.toggle_overlay()<CR>", {desc = "Toggle git diff overlay"})

-- mini.pick
vim.keymap.set("n", "<leader> ", ":Pick files<CR>", {desc = "mini.pick files"})
vim.keymap.set("n", "<leader>G", ":Pick grep<CR>", {desc = "mini.pick grep current buffer"})
vim.keymap.set("n", "<leader>/", ":Pick grep_live<CR>", {desc = "mini.pick grep cwd"})
vim.keymap.set("n", "<leader>ff", ":Pick files<CR>", {desc = "pick files"})
vim.keymap.set("n", "<leader>fg", ":Pick grep<CR>", {desc = "grep cwd"})
vim.keymap.set("n", "<leader>fb", ":Pick buffers<CR>", {desc = "pick buffers"})
vim.keymap.set("n", "<leader>fh", ":Pick help<CR>", {desc = "mini.pick help"})
