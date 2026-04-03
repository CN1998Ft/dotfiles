local has_icons, MiniIcons = pcall(require, "mini.icons")
git_icons, _, _ = MiniIcons.get("filetype", "git")
conf_icons, _, _ = MiniIcons.get("filetype", "config")
return {
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            preset = "helix",
            spec = {
                {"<leader> ", icon = "󰱽"},
                {"<leader>e", icon = "󰙅"},
                {"<leader>n", icon = "󰝒"},
                {"gh", icon = {icon = git_icons, hl = "MiniIconsOrange"}},
                {"gH", icon = {icon = git_icons, hl = "MiniIconsOrange"}},
                {"<leader>f", group = "mini.pick", icon = "󰍉"},
                {"<leader>fh", icon = {icon = "󰋖", hl = "MiniIconsRed"}},
                {"<leader>fg", icon = {icon = "󰍉", hl = "MiniIconsAzura"}},
                {"<leader>f/", icon = {icon = "󰍉", hl = "MiniIconsRed"}},
                {"<leader>ff", icon = "󰱽"},
                {"<leader>fb", icon = ""},
                {"<leader>fc", icon = {icon = conf_icons, hl = "MiniIconsBlue"}},
                {"<leader>fH", icon = { icon = "󰛢", hl = "MiniIconsPurple"}},
                {"<leader>G", icon = {icon = "󰍉", hl = "MiniIconsGreen"}},
                {"<leader>/", icon = {icon = "󰍉", hl = "MiniIconsRed"}},
                {"<leader>b", group = "buffers", icon = ""},
                {"<leader>bb", icon = ""},
                {"<leader>bd", icon = ""},
                {"<leader>bp", icon = ""},
                {"<leader>bn", icon = ""},
                {"<leader>H", icon = { icon = "󰛢", hl = "MiniIconsPurple"}},
                {"<leader>h", icon = {icon = "󰀱", hl = "MiniIconsPurple"}},
                {"<leader>0", hidden = true},
                {"<leader>1", icon = { icon = "󱡀", hl = "MiniIconsPurple"}},
                {"<leader>2", icon = { icon = "󱡀", hl = "MiniIconsPurple"}},
                {"<leader>3", icon = { icon = "󱡀", hl = "MiniIconsPurple"}},
                {"<leader>4", icon = { icon = "󱡀", hl = "MiniIconsPurple"}},
                {"<leader>5", icon = { icon = "󱡀", hl = "MiniIconsPurple"}},
                {"<leader>6", icon = { icon = "󱡀", hl = "MiniIconsPurple"}},
                {"<leader>7", icon = { icon = "󱡀", hl = "MiniIconsPurple"}},
                {"<leader>8", icon = { icon = "󱡀", hl = "MiniIconsPurple"}},
                {"<leader>9", icon = { icon = "󱡀", hl = "MiniIconsPurple"}},
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
