vim.pack.add({ "https://github.com/nvim-lualine/lualine.nvim" })
local function get_osicon()
  local os_name = vim.uv.os_uname().sysname
  local icon
  if os_name == "Darwin" then
    icon = ""
  elseif os_name == "Linux" then
    icon = "󰣛"
  end
  return icon
end

local lualine = require("lualine")
local opts = {
  options = {
    theme = "everforest",
    globalstatue = true,
    ignore_focus = { "terminal" },
  },
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
        cond = function()
          local mode = vim.api.nvim_get_mode()
          return mode.mode ~= "t"
        end,
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
          unix = get_osicon(),
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
  inactive_sections = {
    lualine_a = { "filename" },
    lualine_b = { "branch" },
    lualine_c = { "diff" },
    lualine_z = { "location" },
  },
}
lualine.setup(opts)
