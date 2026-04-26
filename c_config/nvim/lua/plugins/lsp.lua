vim.pack.add({
  "https://github.com/mason-org/mason.nvim",
  "https://github.com/neovim/nvim-lspconfig",
  {
    src = "https://github.com/saghen/blink.cmp",
    version = vim.version.range("1.*"),
  },
})

require("mason").setup({})

-- Install debug adapter
local install_mason = {
  "local-lua-debugger-vscode",
  "lua-language-server",
  "stylua",
  "ruff",
  "python-lsp-server",
  "clangd",
}
local install_mason_win = vim.fn.deepcopy(install_mason)
table.insert(install_mason_win, "codelldb") -- Linux has gdb and Darwin has lldb preinstalled
local is_win = vim.uv.os_uname().sysname == "Windows_NT"
local to_install
if is_win then
  to_install = install_mason_win
else
  to_install = install_mason
end

local already_installed = require("mason-registry").get_installed_package_names()
for _, debugger in ipairs(to_install) do
  if not vim.list_contains(already_installed, debugger) then
    print(string.format("The bugger %s is not installed", debugger))
    vim.cmd("MasonInstall " .. debugger)
  end
end

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
  "clangd",
})

-- Disable diagnostic signs, but with underline and text color
vim.diagnostic.config({
  signs = false,
})
