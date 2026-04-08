vim.pack.add({
  {
    src = "https://github.com/nvim-treesitter/nvim-treesitter",
    -- Keep this until the treesitter is above 0.26.1 on fedora
    version = "main",
    build = ":TSUpdate",
  },
})

local treesitter = require("nvim-treesitter")
treesitter.setup({
  install_dir = vim.fs.normalize(vim.fn.stdpath("data") .. "/sit"),
})

ensure_installed = {
  "c",
  "cpp",
  "make",
  "cmake",
  "ninja",
  "lua",
  "vim",
  "vimdoc",
  "query",
  "markdown",
  "markdown_inline",
  "bash",
  "powershell",
  "python",
  "bibtex",
  "xml",
  "html",
  "toml",
  "yaml",
  "git_config",
  "git_rebase",
  "gitcommit",
  "gitignore",
  "diff",
  "regex",
}

local installed_parsers = treesitter.get_installed()
local parsers_to_install = {}
for _, parser in ipairs(ensure_installed) do
  if not vim.tbl_contains(installed_parsers, parser) then
    table.insert(parsers_to_install, parser)
  end
end

if #parsers_to_install > 0 then
  treesitter.install(parsers_to_install)
end
