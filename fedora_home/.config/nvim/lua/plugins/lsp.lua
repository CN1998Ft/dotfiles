vim.pack.add({
  "https://github.com/mason-org/mason.nvim",
  "https://github.com/mason-org/mason-lspconfig.nvim",
  "https://github.com/neovim/nvim-lspconfig",
})

-- vim.cmd("packadd mason-lspconfig.nvim")
require("mason").setup({})
require("mason-lspconfig").setup({
  ensure_installed = {
    "lua_ls",
  },
})

vim.lsp.config("lua_ls", {
  setting = {
    lua = {
      diagnostics = { global = { "vim" } },
      telemetry = { enable = false },
    },
  },
})

vim.lsp.enable({
  "lua_ls",
})
