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
}
