vim.pack.add({
  "https://github.com/nvim-mini/mini.icons",
  "https://github.com/nvim-mini/mini.pick",
  "https://github.com/nvim-mini/mini.diff",
  "https://github.com/nvim-mini/mini.trailspace",
})

-- icons
local icons = require("mini.icons")
icons.setup({ style = "glyph" })
icons.mock_nvim_web_devicons()

-- pick
local picker = require("mini.pick")
local opts = {
  delay = {
    async = 10,
    busy = 50,
  },
  window = {
    config = function()
      local h = math.floor(0.5 * vim.o.lines)
      local w = math.floor(0.5 * vim.o.columns)
      return {
        anchor = "NW",
        height = h,
        width = w,
        row = math.floor(0.5 * vim.o.lines),
        col = 0,
      }
    end,
  },
}
picker.setup(opts)

-- diff
local diff = require("mini.diff")
opts = {
  view = {
    style = "number",
  },
  delay = {
    text_change = 300,
  },
}
diff.setup(opts)

-- trailspace
local trailspace = require("mini.trailspace")
opts = { only_in_normal_buffers = true }
trailspace.setup(opts)
