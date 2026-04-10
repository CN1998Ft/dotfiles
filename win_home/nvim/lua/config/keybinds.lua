-- For compatible reasons, the icons and group is defined inside the
-- plugins/whichkey.lua
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>e", ":Explore<CR>", { desc = "Explorer" })
vim.keymap.set("n", "<leader>n", ":tabnew<CR>", { desc = "New file" })
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window", remap = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window", remap = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", remap = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
vim.keymap.set("n", "<S-h>", ":tabprevious<CR>", { desc = "Go to left tab", remap = true })
vim.keymap.set("n", "<S-l>", ":tabnext<CR>", { desc = "Go to left tab", remap = true })
-- Use Comment.nvim instead
-- vim.keymap.set("n", "gco", "o<Esc>Vcx<Esc><Cmd>normal gcc<CR>fxa<BS>", {desc = "Comment below"})
-- vim.keymap.set("n", "gcO", "O<Esc>Vcx<Esc><Cmd>normal gcc<CR>fxa<BS>", {desc = "Comment above"})
vim.keymap.set("n", "<leader>r", function()
  require("config.Fengtao").restart_session()
end, { desc = "Restart", remap = false })

-- Floating terminal
vim.keymap.set(
  "n",
  "<leader>t",
  require("config.terminal").termOpen,
  { noremap = true, desc = "Toggle Floating Terminal" }
)
vim.keymap.set(
  "t",
  "<Esc>",
  require("config.terminal").termClose,
  { noremap = true, desc = "Toggle Floating Terminal" }
)

-- buffers
vim.keymap.set("n", "<leader>bd", ":bd<CR>", { desc = "Delete the current buffer" })
vim.keymap.set("n", "<leader>bb", ":Pick buffers<CR>", { desc = "mini.pick buffers" })
vim.keymap.set("n", "<leader>bp", ":bp<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "<leader>bn", ":bn<CR>", { desc = "Next buffer" })

-- mini.diff
vim.keymap.set("n", "<leader>o", ":lua MiniDiff.toggle_overlay()<CR>", { desc = "Toggle git diff overlay" })

-- mini.pick
vim.keymap.set("n", "<leader> ", ":Pick files<CR>", { desc = "mini.pick files" })
vim.keymap.set("n", "<leader>G", ":Pick grep<CR>", { desc = "mini.pick grep" })
vim.keymap.set("n", "<leader>/", ":Pick grep_live<CR>", { desc = "mini.pick live_grep" })
vim.keymap.set("n", "<leader>ff", function()
  require("config.Fengtao").pick_dir_file()
end, { desc = "pick dirs and files" })
vim.keymap.set("n", "<leader>fg", ":Pick grep<CR>", { desc = "pick grep" })
vim.keymap.set("n", "<leader>fb", ":Pick buffers<CR>", { desc = "pick buffers" })
vim.keymap.set("n", "<leader>f/", ":Pick grep_live<CR>", { desc = "pick live grep" })
vim.keymap.set("n", "<leader>fh", ":Pick help<CR>", { desc = "grep through help files" })
vim.keymap.set("n", "<leader>fc", function()
  require("config.Fengtao").pick_config()
end, { desc = "pick config" })

-- Code related, mason and stuff
vim.keymap.set("n", "<leader>cm", ":Mason<CR>", { desc = "Mason TUI" })
vim.keymap.set("n", "<leader>cc", ":checkhealth vim.lsp<CR>", { desc = "check lsp info" })
vim.keymap.set("n", "<leader>cC", ":checkhealth nvim-treesitter<CR>", { desc = "check nvim-treesitter parsers" })
vim.keymap.set("n", "<leader>ct", ":Inspect<CR>", { desc = "treesitter Inspect" })
vim.keymap.set("n", "<leader>cT", ":InspectTree<CR>", { desc = "treesitter InspectTree" })

-- vim.pack
vim.keymap.set("n", "<leader>pv", function()
  vim.pack.update(nil, { offline = true })
end, { desc = "pack list" })
vim.keymap.set("n", "<leader>pu", function()
  vim.pack.update(nil, { force = true })
end, { desc = "pack update all" })

-- nvim-dap
vim.keymap.set("n", "<leader>dc", function()
  require("dap").continue()
end, { desc = "Debug continue" })
vim.keymap.set("n", "<leader>dt", function()
  require("dap").terminate()
end, { desc = "Terminate session" })
vim.keymap.set("n", "<leader>db", function()
  require("dap").toggle_breakpoint()
end, { desc = "Toggle breakpoint" })
vim.keymap.set("n", "<leader>dB", function()
  require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, { desc = "Breakpoint condition" })
vim.keymap.set("n", "<leader>dv", ":DapViewToggle<CR>", { desc = "Toggle dap-view" })
vim.keymap.set("n", "<leader>da", function()
  local args_string = vim.fn.input("Arguments: ")
  local args = {}
  if args_string ~= "" then
    args = vim.split(args_string, " +")
  end
  require("dap").continue({ args = args })
end, { desc = "Run with Args" })
vim.keymap.set("n", "<leader>dC", function()
  require("dap").run_to_cursor()
end, { desc = "Run to Cursor" })
vim.keymap.set("n", "<leader>dg", function()
  require("dap").goto_()
end, { desc = "Go to Line (No Execute)" })
vim.keymap.set("n", "<leader>di", function()
  require("dap").step_into()
end, { desc = "Step Into" })
vim.keymap.set("n", "<leader>dj", function()
  require("dap").down()
end, { desc = "Down" })
vim.keymap.set("n", "<leader>dk", function()
  require("dap").up()
end, { desc = "Up" })
vim.keymap.set("n", "<leader>dl", function()
  require("dap").run_last()
end, { desc = "Run Last" })
vim.keymap.set("n", "<leader>do", function()
  require("dap").step_out()
end, { desc = "Step Out" })
vim.keymap.set("n", "<leader>dO", function()
  require("dap").step_over()
end, { desc = "Step Over" })
vim.keymap.set("n", "<leader>dr", function()
  require("dap").restart()
end, { desc = "Restart debug" })
vim.keymap.set("n", "<leader>ds", function()
  require("dap").session()
end, { desc = "Session" })
-- NOTE1: harpoon not working for now
-- harpoon
-- vim.keymap.set("n", "<leader>H", function()
--     require("harpoon"):list():add()
-- end, {desc = "Harpoon file"})
-- vim.keymap.set("n", "<leader>fH", function()
--     require("config.Fengtao").harpoon_pick_menu()
-- end, {desc = "Harpoon picker"})
-- vim.keymap.set("n", "<leader>h", function()
--     require("harpoon").ui:toggle_quick_menu(require("harpoon"):list())
-- end, {desc = "Harpoon quick menu"})
--
-- -- harpoon files jumping
-- vim.keymap.set("n", "<leader>1", function()
--     require("harpoon"):list():select(1)
-- end, {desc = "Harpoon to file 1"})
-- vim.keymap.set("n", "<leader>2", function()
--     require("harpoon"):list():select(2)
-- end, {desc = "Harpoon to file 2"})
-- vim.keymap.set("n", "<leader>3", function()
--     require("harpoon"):list():select(3)
-- end, {desc = "Harpoon to file 3"})
-- vim.keymap.set("n", "<leader>4", function()
--     require("harpoon"):list():select(4)
-- end, {desc = "Harpoon to file 4"})
-- vim.keymap.set("n", "<leader>5", function()
--     require("harpoon"):list():select(5)
-- end, {desc = "Harpoon to file 5"})
-- vim.keymap.set("n", "<leader>6", function()
--     require("harpoon"):list():select(6)
-- end, {desc = "Harpoon to file 6"})
-- vim.keymap.set("n", "<leader>7", function()
--     require("harpoon"):list():select(7)
-- end, {desc = "Harpoon to file 7"})
-- vim.keymap.set("n", "<leader>8", function()
--     require("harpoon"):list():select(8)
-- end, {desc = "Harpoon to file 8"})
-- vim.keymap.set("n", "<leader>9", function()
--     require("harpoon"):list():select(9)
-- end, {desc = "Harpoon to file 9"})
-- vim.keymap.set("n", "<leader>0", function()
--     require("harpoon"):list():select(10)
-- end, {desc = "Harpoon to file 10"})
