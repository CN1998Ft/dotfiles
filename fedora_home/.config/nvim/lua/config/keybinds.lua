vim.g.mapleader = " "
vim.keymap.set("n", "<leader>e", vim.cmd.Ex)
vim.keymap.set("n", "<leader>t", ':below term<CR> | :resize 15<CR>', {desc = "Open terminal below"})
