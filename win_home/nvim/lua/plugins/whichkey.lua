local has_icons, MiniIcons = pcall(require, "mini.icons")
git_icons, _, _ = MiniIcons.get("filetype", "git")
return {
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            preset = "helix",
            spec = {
                {"<leader>f", group = "mini.pick", icon = "󰍉"},
                {"gh", icon = {icon = git_icons, hl = "MiniIconsOrange"}},
                {"gH", icon = {icon = git_icons, hl = "MiniIconsOrange"}},
                {"<leader>fh", icon = {icon = "󰋖", hl = "MiniIconsRed"}},
                {"<leader>fg", icon = {icon = "󰍉", hl = "MiniIconsAzura"}},
                {"<leader>G", icon = {icon = "󰍉", hl = "MiniIconsGreen"}},
                {"<leader>/", icon = {icon = "󰍉", hl = "MiniIconsRed"}},
                {"<leader>b", group = "buffers", icon = ""},
                {"<leader> ", icon = "󰱽"},
                {"<leader>ff", icon = "󰱽"},
                {"<leader>fb", icon = ""},
                {"<leader>e", icon = "󰙅"},
                {"<leader>bb", icon = ""},
                {"<leader>bd", icon = ""},
                {"<leader>bp", icon = ""},
                {"<leader>bn", icon = ""},
            },
        },
        keys = {
            {
                "<leader>?",
                function()
                    require("which-key").show({ global = false })
                end,
                desc = "Buffer Local keymaps (which-key)",
            },
        },
    },
}
