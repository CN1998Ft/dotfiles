return {
    {
        "nvim-mini/mini.icons",
        version = false,
        lazy = false,
        priority = 1000,
        opts = {
        },
        config = function(_, opts)
            local icons = require("mini.icons")
            icons.setup(opts)
            icons.mock_nvim_web_devicons()
        end,
    },
    {
        "nvim-mini/mini.pick",
        version = false,
        lazy = false,
        opts = {
            delay = {
                async = 10,
                busy = 50,
            },
        },
        config = function(_, opts)
            local picker = require("mini.pick")
            picker.setup(opts)
        end,
    },
    {
        "nvim-mini/mini.diff",
        version = false,
        opts = {
            view = {
                style = vim.go.number and 'sign',
                signs = { add = '▒', change = '▒',delete = '▒' },
                priority = 199,
            },
            delay = {
                text_change = 300,
            },
        },
        config = function(_, opts)
            local git_diff = require("mini.diff")
            git_diff.setup(opts)
        end,
    },
    {
        "nvim-mini/mini.trailspace",
        version = false,
        opts = {
            only_in_normal_buffers = true,
        },
        config = function(_, opts)
            local trailspace = require("mini.trailspace")
            trailspace.setup(opts)
        end,
    },
}
