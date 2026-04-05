return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        branch = "master",
        config = function()
            require("nvim-treesitter.configs").setup({
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
                    "latex",
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
                        if ok and stats and stats.size > max_filesize then
                            return true
                        end
                    end,

                    additional_vim_regex_highlight = false,
                },
            })
        end,
    }
}
