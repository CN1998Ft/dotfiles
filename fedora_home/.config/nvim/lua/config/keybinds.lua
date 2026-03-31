vim.g.mapleader = " "
vim.keymap.set("n", "<leader>e", vim.cmd.Ex)
vim.keymap.set("n", "<leader>t", ':below term<CR> | :resize 15<CR>', {desc = "Open terminal below"})

-- mini.pick
vim.keymap.set("n", "<leader> ", ":Pick files<CR>", {desc = "mini.pick files"})
vim.keymap.set("n", "<leader>bb", ":Pick buffers<CR>", {desc = "mini.pick buffers"})
vim.keymap.set("n", "<leader>g", ":Pick grep<CR>", {desc = "mini.pick grep current buffer"})
vim.keymap.set("n", "<leader>G", ":Pick grep_live<CR>", {desc = "mini.pick grep cwd"})
vim.keymap.set("n", "<leader>h", ":Pick help<CR>", {desc = "mini.pick help"})
