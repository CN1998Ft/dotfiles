vim.pack.add({
  "https://github.com/mfussenegger/nvim-dap",
  "https://github.com/igorlfs/nvim-dap-view",
  "https://github.com/Jorenar/nvim-dap-disasm",
})

local dapview = require("dap-view")
local view_opts = {
  winbar = {
    show = true,
    sections = {
      "watches",
      "scopes",
      "exceptions",
      "repl",
      "disassembly",
      "breakpoints",
      "threads",
      "console",
      "sessions",
    },
    default_section = "watches",
    show_keymap_hints = true,
    base_sections = {
      breakpoints = { label = "Breakpoints", keymap = "B" },
      scopes = { label = "Scopes", keymap = "S" },
      exceptions = { label = "Exceptions", keymap = "E" },
      watches = { label = "Watches", keymap = "W" },
      threads = { label = "Threads", keymap = "T" },
      repl = { label = "REPL", keymap = "R" },
      sessions = { label = "Sessions", keymap = "K" },
      console = { label = "Console", keymap = "C" },
    },
    custom_sections = {},
    controls = {
      enabled = true,
      position = "right",
      buttons = {
        "play",
        "step_into",
        "step_over",
        "step_out",
        "step_back",
        "run_last",
        "terminate",
        "disconnect",
      },
      custom_buttons = {},
    },
  },
  windows = {
    size = 0.25,
    position = "below",
    terminal = {
      size = 0.5,
      position = "left",
      hide = {},
    },
  },
  help = {
    border = nil,
  },
}
dapview.setup(view_opts)

local disasm = require("dap-disasm")
local disasm_opts = {
  dapview_register = true,
  dapview = {
    keymap = "D",
    label = "Disassembly",
    short_label = "󰒓",
  },
}
disasm.setup(disasm_opts)

local dap = require("dap")

-- Get python for config
local function find_python()
  local cwd = vim.fn.getcwd()
  local is_windows = vim.uv.os_uname().sysname == "Windows_NT"
  local python_bin = is_windows and "/python.exe" or "/bin/python"

  -- 1. Check for local .venv or venv
  local venv_path = vim.fs.normalize(cwd .. "/.venv" .. python_bin)
  local venv_path_alt = vim.fs.normalize(cwd .. "/venv" .. python_bin)

  if vim.fn.executable(venv_path) == 1 then
    return venv_path
  elseif vim.fn.executable(venv_path_alt) == 1 then
    return venv_path_alt
  end

  local conda_prefix = os.getenv("CONDA_PREFIX")
  if conda_prefix then
    local conda_python = vim.fs.normalize(conda_prefix .. python_bin)
    if vim.fn.executable(conda_python) == 1 then
      return conda_python
    end
  end

  vim.notify(
    "DAP: No active environment found (.venv, venv, or Conda). Please activate an environment.",
    vim.log.levels.ERROR,
    { title = "Nvim-DAP" }
  )

  return "python3"
end

dap.configurations.python = {
  {
    type = "python",
    request = "launch",
    name = "Launch file",
    program = "${file}",
    pythonPath = find_python(),
  },
  {
    type = "python",
    request = "attach",
    name = "Attach to remote debugger",
    connect = {
      host = "127.0.0.1",
      port = 5678,
    },
  },
}

dap.adapters.python = function(cb, config)
  if config.request == "attach" then
    local port = (config.connect or config).port
    local host = (config.connect or config).host or "127.0.0.1"
    cb({
      type = "server",
      port = assert(port, "`connect.port` is required for a python `attach` configuration"),
      host = host,
      options = {
        source_filetype = "python",
      },
    })
  else
    cb({
      type = "executable",
      command = find_python(),
      args = { "-m", "debugpy.adapter" },
      options = {
        source_filetype = "python",
      },
    })
  end
end

-- Dap trigger the dap-view
dap.listeners.after["event_initialized"]["dap_show_view"] = function()
  dapview.open()
end

dap.listeners.before["event_terminated"]["dap_show_view"] = function()
  dapview.close()
end

dap.listeners.before["event_exited"]["dap_show_view"] = function()
  dapview.close()
end
