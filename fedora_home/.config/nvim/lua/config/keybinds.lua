-- For compatible reasons, the icons and group is defined inside the
-- plugins/whsichkey.lua
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>e", ":Explore<CR>", {desc = "Explorer"})
vim.keymap.set("n", "<leader>n", ":tabnew<CR>", {desc = "New file"})
vim.keymap.set("n", "<C-h>", "<C-w>h", {desc = "Go to left window",remap = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", {desc = "Go to right window",remap = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", {desc = "Go to lower window",remap = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", {desc = "Go to upper window",remap = true })
vim.keymap.set("n", "<S-h>", ":tabprevious<CR>", {desc = "Go to left tab",remap = true })
vim.keymap.set("n", "<S-l>", ":tabnext<CR>", {desc = "Go to left tab",remap = true })
vim.keymap.set("n", "gco", "o<Esc>Vcx<Esc><Cmd>normal gcc<CR>fxa<BS>", {desc = "Comment below"})
vim.keymap.set("n", "gcO", "O<Esc>Vcx<Esc><Cmd>normal gcc<CR>fxa<BS>", {desc = "Comment above"})

-- Floating terminal
vim.keymap.set("n", "<leader>t", require("config.terminal").termOpen, {noremap = true, desc = "Toggle Floating Terminal"})
vim.keymap.set("t", "<Esc>", require("config.terminal").termClose, {noremap = true, desc = "Toggle Floating Terminal"})

-- Lazy
vim.keymap.set("n", "<leader>l", ":Lazy<CR>", {desc = "lazy.nvim"})

-- buffers
vim.keymap.set("n", "<leader>bd", ":bd<CR>", {desc = "Delete the current buffer"})
vim.keymap.set("n", "<leader>bb", ":Pick buffers<CR>", {desc = "mini.pick buffers"})
vim.keymap.set("n", "<leader>bp", ":bp<CR>", {desc = "Previous buffer"})
vim.keymap.set("n", "<leader>bn", ":bn<CR>", {desc = "Next buffer"})

-- mini.diff
vim.keymap.set("n", "<leader>o", ":lua MiniDiff.toggle_overlay()<CR>", {desc = "Toggle git diff overlay"})

-- mini.pick
vim.keymap.set("n", "<leader> ", ":Pick files<CR>", {desc = "mini.pick files"})
vim.keymap.set("n", "<leader>G", ":Pick grep<CR>", {desc = "mini.pick grep"})
vim.keymap.set("n", "<leader>/", ":Pick grep_live<CR>", {desc = "mini.pick live_grep"})
vim.keymap.set("n", "<leader>ff", function()
    require("config.Fengtao").pick_dir_file()
end, {desc = "pick dirs and files"})
vim.keymap.set("n", "<leader>fg", ":Pick grep<CR>", {desc = "pick grep"})
vim.keymap.set("n", "<leader>fb", ":Pick buffers<CR>", {desc = "pick buffers"})
vim.keymap.set("n", "<leader>f/", ":Pick grep_live<CR>", {desc = "pick live grep"})
vim.keymap.set("n", "<leader>fh", ":Pick help<CR>", {desc = "grep through help files"})
vim.keymap.set("n", "<leader>fc", function()
    require("config.Fengtao").pick_config()
end, {desc = "pick config"})

-- harpoon
vim.keymap.set("n", "<leader>H", function()
    require("harpoon"):list():add()
end, {desc = "Harpoon file"})
vim.keymap.set("n", "<leader>fH", function()
    require("config.Fengtao").harpoon_pick_menu()
end, {desc = "Harpoon picker"})
vim.keymap.set("n", "<leader>h", function()
    require("harpoon").ui:toggle_quick_menu(require("harpoon"):list())
end, {desc = "Harpoon quick menu"})

-- harpoon files jumping
vim.keymap.set("n", "<leader>1", function()
    require("harpoon"):list():select(1)
end, {desc = "Harpoon to file 1"})
vim.keymap.set("n", "<leader>2", function()
    require("harpoon"):list():select(2)
end, {desc = "Harpoon to file 2"})
vim.keymap.set("n", "<leader>3", function()
    require("harpoon"):list():select(3)
end, {desc = "Harpoon to file 3"})
vim.keymap.set("n", "<leader>4", function()
    require("harpoon"):list():select(4)
end, {desc = "Harpoon to file 4"})
vim.keymap.set("n", "<leader>5", function()
    require("harpoon"):list():select(5)
end, {desc = "Harpoon to file 5"})
vim.keymap.set("n", "<leader>6", function()
    require("harpoon"):list():select(6)
end, {desc = "Harpoon to file 6"})
vim.keymap.set("n", "<leader>7", function()
    require("harpoon"):list():select(7)
end, {desc = "Harpoon to file 7"})
vim.keymap.set("n", "<leader>8", function()
    require("harpoon"):list():select(8)
end, {desc = "Harpoon to file 8"})
vim.keymap.set("n", "<leader>9", function()
    require("harpoon"):list():select(9)
end, {desc = "Harpoon to file 9"})
vim.keymap.set("n", "<leader>0", function()
    require("harpoon"):list():select(10)
end, {desc = "Harpoon to file 10"})
