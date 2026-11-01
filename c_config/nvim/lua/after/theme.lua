local theme = vim.g.colors_name
if theme == "default" then
    vim.api.nvim_set_hl(0, "Normal", {
        bg = "#0a0c10",
        fg = "NvimLightGrey2",
    })
end
