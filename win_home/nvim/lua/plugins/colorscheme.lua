return {
    {
        "neanias/everforest-nvim",
        version = false,
        lazy = false,
        priority = 1000,
        config = function()
            require("everforest").setup({
                background = "hard",
                transparent_backgroud_level = 0,
                ui_contrast = "high",
            })
            vim.cmd([[colorscheme everforest]])
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        opts = {
            theme = "everforest",
            sections = {
                lualine_a = { "mode" },
                lualine_b = {
                    { "branch" },
                    {
                        "diff",
                        symbols = {
                            added = " ",
                            modified = " ",
                            removed = " ",
                        },
                    },
                    { "diagnostics" },
                },
                lualine_c = {
                    {
                        "filetype",
                        colored = true,
                        icon_only = true,
                        icon = { align = "left" },
                        padding = { left = 1, right = -1 },
                        separator = " ",
                    },
                    {
                        "filename",
                        file_status = true,
                        newfile_status = true,
                        path = 1,
                        padding = { left = -1 },
                    },
                },
                lualine_x = {
                    {
                        "searchcount",
                        maxcount = 999,
                        timeout = 500,
                    },
                    {
                        "fileformat",
                        symbols = {
                            unix = "󰣛 ",
                        },
                    },
                },
                lualine_y = {
                    {
                        "progress",
                        padding = { left = 1, right = -1 },
                        separator = " ",
                    },
                    { "location", padding = -1, separator = " " },
                },
                lualine_z = {
                    {
                        "datetime",
                        style = " %H:%M",
                    },
                },
            },
        },
    },
}
