vim.pack.add({
  "https://github.com/nvim-mini/mini.icons",
  "https://github.com/nvim-mini/mini.pick",
  "https://github.com/nvim-mini/mini.diff",
  "https://github.com/nvim-mini/mini.trailspace",
  "https://github.com/nvim-mini/mini.indentscope",
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
    -- style = "sign",
    -- signs = { add = "+", change = "~", delete = "-" },
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

-- indentscope
local indent = require("mini.indentscope")
opts = {
  draw = {
    delay = 100,
    animation = indent.gen_animation.quadratic({
      easing = "out",
      duration = 20, -- duration in milliseconds
      unit = "total", -- 'total' or 'step'
    }),
    predicate = function(scope)
      local min_line = 4 -- minimual line of scope required to draw
      local body_line = scope.body.bottom - scope.body.top
      local state = ((not scope.body.is_incomplete) and body_line >= min_line)
      return state
    end,
  },
  options = {
    border = "both",
    indent_at_cursor = true,
    -- Maximum number of lines above or below within which scope is computed
    n_lines = 1000,
    try_as_border = true,
  },
  symbol = "╎",
}
indent.setup(opts)
