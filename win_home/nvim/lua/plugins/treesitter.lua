vim.pack.add({
  {
    src = "https://github.com/nvim-treesitter/nvim-treesitter",
    -- Keep this until the treesitter is above 0.26.1 on fedora
    version = "master",
    build = ":TSUpdate",
  },
})

-- This require has to be done in this format, and not like the treesitter.setup()
require("nvim-treesitter.configs").setup({
  parser_install_dir = vim.fs.normalize(vim.fn.stdpath("data") .. "/site"),
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
  },
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
    disable = function(lang, buf)
      local max_filesize = 100 * 1024
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if of and stats and stats.size > max_filesize then
        return true
      end
    end,
    additional_vim_regex_highlight = false,
  },
})

local treesitter = require("nvim-treesitter")
treesitter.setup({})
