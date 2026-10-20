vim.pack.add({ "https://github.com/nvim-lualine/lualine.nvim" })
---@return string
local function get_osicon()
  local os_name = vim.uv.os_uname().sysname
  local icon
  if os_name == "Darwin" then
    icon = ""
  elseif os_name == "Linux" then
    icon = "󰣛"
  elseif os_name == "Windows_NT" then
    icon = ""
  end
  return icon
end

local lualine = require("lualine")
local opts = {
  options = {
    theme = "iceberg_dark",
    globalstatus = true,
    ignore_focus = { "terminal" },
    disabled_filetypes = {
      statusline = {},
      winbar = { "dap-view" },
    },
  },
  always_show_tabline = false,
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
        icon_only = false,
        icon = { align = "left" },
        padding = { left = 1, right = -1 },
        separator = " 󰿄 ",
      },
      {
        "filename",
        file_status = true,
        newfile_status = true,
        path = 1,
        cond = function()
          local buftype = vim.bo.buftype
          return buftype ~= "help"
        end,
      },
      {
        "filename",
        path = 4,
        padding = { left = 0 },
        cond = function()
          local buftype = vim.bo.buftype
          return buftype == "help"
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
        -- Get the icon showing
        get_osicon,
      },
      { "filesize" },
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
  tabline = {
    lualine_a = {
      {
        "buffers",
        mode = 4,
        buffers_color = {
          active = { fg = "#ddb7ff", bg = "#000000", gui = "bold" }, --[cite: 1]
          inactive = { fg = "#aaaaaa", bg = "#111111", gui = "italic" }, --[cite: 1]
        },
        separator = { left = "", right = "" },
      },
    },
    lualine_z = {
      {
        "lsp_status",
        icon = "󱔼",
        symbols = {
          -- Standard unicode symbols to cycle through for LSP progress:
          spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
          -- Standard unicode symbol for when LSP is done:
          done = "",
          -- Delimiter inserted between LSP names:
          separator = "|",
        },
        -- List of LSP names to ignore (e.g., `null-ls`):
        ignore_lsp = {},
        -- Display the LSP name
        show_name = true,
        color = { fg = "#91cbff", bg = "#111111" },
      },
    },
  },
  inactive_winbar = {
    lualine_a = { "filename" },
    lualine_b = { "branch" },
    lualine_c = { "diff" },
    lualine_z = { "location" },
  },
}
lualine.setup(opts)
