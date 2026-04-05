return {
    {
        "neanias/everforest-nvim",
        version = false,
        lazy = false,
        priority = 1000,
        config = function ()
            require("everforest").setup({
                background = "hard",
                transparent_backgroud_level = 0,
                ui_contrast = "high",
            })
            -- vim.cmd([[colorscheme everforest]])
            require("everforest").load()
        end
    },
--     {
--         "ellisonleao/gruvbox.nvim",
--         priority = 1000,
--         lazy = true,
--         config = true,
--         opts = {
--             terminal_colors = true,
--             undercurl = true,
--             underline = true,
--             bold = true,
--             italic = {
--             strings = true,
--             emphasis = true,
--             comments = true,
--             operators = false,
--             folds = true,
--             },
--             strikethrough = true,
--             invert_selection = false,
--             invert_signs = false,
--             invert_tabline = false,
--             inverse = true,
--             contrast = "",
--             palette_overrides = {},
--             overrides = {},
--             dim_inactive = false,
--             transparent_mode = false,
--         },
--         config = function()
--             local gruvbox = require("gruvbox")
--             gruvbox.setup(opts)
--             -- vim.cmd("colorscheme gruvbox")
--         end
--     },
}
