vim.pack.add({
  "https://github.com/mason-org/mason.nvim",
  "https://github.com/mason-org/mason-lspconfig.nvim",
  "https://github.com/neovim/nvim-lspconfig",
  {
    src = "https://github.com/saghen/blink.cmp",
    version = vim.version.range("1.*"),
  },
})

-- vim.cmd("packadd mason-lspconfig.nvim")
require("mason").setup({})
require("mason-lspconfig").setup({
  ensure_installed = {
    "lua_ls",
    "stylua",
    "ruff",
    "pylsp",
  },
})

-- get blink.cmp for lsp completion
local blinkcmp = require("blink.cmp")
local opts = {
  completion = {
    keyword = {
      range = "prefix",
    },
    trigger = {
      show_on_keyword = true,
    },
    list = {
      selection = {
        preselect = true,
        auto_insert = false,
      },
    },
    menu = {
      auto_show = false,
    },
  },
  keymap = {
    preset = "none",
    ["<C-e>"] = { "show", "hide" },
    ["<C-y>"] = { "accept", "fallback" },
    ["<C-n>"] = { "select_next", "fallback" },
    ["<C-p>"] = { "select_prev", "fallback" },
  },
}

blinkcmp.setup(opts)
vim.lsp.config("*", {
  capabilities = blinkcmp.get_lsp_capabilities(),
})

-- Enable lsp
vim.lsp.config("lua_ls", {
  settings = {
    lua = {
      format = { enable = false },
      diagnostics = { globals = { "vim" } },
      telemetry = { enable = false },
    },
  },
})

vim.lsp.enable({
  "lua_ls",
  "stylua",
  "ruff",
  "pylsp",
})

-- Disable diagnostic signs, but with underline and text color
vim.diagnostic.config({
  signs = false,
})
