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
  local is_windows = vim.uv.os_uname().sysname == "Windows_NT"
  local _python_bin = is_windows and "/Scripts/python.exe" or "/bin/python"
  local cwd = vim.fn.getcwd()
  local venv = vim.fs.normalize(cwd .. "/.venv" .. _python_bin)
  local alt_venv = vim.fs.normalize(cwd .. "/venv" .. _python_bin)

  local python_bin
  if vim.fn.executable(venv) == 1 then
    python_bin = venv
  elseif vim.fn.executable(alt_venv) == 1 then
    python_bin = alt_venv
  elseif os.getenv("CONDA_PREFIX") then
    local conda
    if is_windows then
      conda = vim.fs.normalize(os.getenv("CONDA_PREFIX") .. "/python.exe")
    else
      conda = vim.fs.normalize(os.getenv("CONDA_PREFIX") .. _python_bin)
    end
    python_bin = conda
  else
    vim.notify(
      "No python environment found, attemping to use global python.",
      vim.log.levels.INFO,
      { title = "Nvim-DAP" }
    )
    python_bin = "python3"
  end
  return python_bin
end

dap.configurations.python = {
  {
    type = "python",
    request = "launch",
    name = "Launch file",
    program = "${file}",
    pythonPath = find_python,
    console = "integratedTerminal",
  },
  {
    type = "python",
    request = "launch",
    name = "Launch with argument",
    program = "${file}",
    pythonPath = find_python,
    console = "integratedTerminal",
    args = function()
      local arg_string = vim.fn.input("Arguments: ")
      return vim.split(arg_string, " +")
    end,
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

-- Lua
dap.adapters["local-lua"] = {
  type = "executable",
  command = "node",
  args = {
    "--trace-deprecation",
    vim.fs.normalize(
      vim.fn.stdpath("data") .. "/mason/packages/local-lua-debugger-vscode/extension/extension/debugAdapter.js"
    ),
  },
  enrich_config = function(config, on_config)
    if not config["extensionPath"] then
      local c = vim.deepcopy(config)
      c.extensionPath =
        vim.fs.normalize(vim.fn.stdpath("data") .. "/mason/packages/local-lua-debugger-vscode/extension/")
      on_config(c)
    else
      on_config(config)
    end
  end,
}

dap.configurations.lua = {
  {
    name = "Current file (local-lua-dbg, lua)",
    type = "local-lua",
    request = "launch",
    cwd = "${workspaceFolder}",
    program = {
      lua = "luajit",
      file = "${file}",
    },
    args = {},
  },
}

-- C/CPP/Rust
local function find_debugger()
  local os_name = vim.uv.os_uname().sysname
  local debugger_bin

  if os_name == "Windows_NT" then
    debugger_bin = vim.fs.normalize(vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/adapter/codelldb.exe")
  elseif os_name == "Darwin" then
    local temp_bin = vim.fn.system("brew --prefix llvm") .. "/bin/lldb-dap"
    debugger_bin = string.gsub(temp_bin, "\n", "")
  elseif os_name == "Linux" then
    debugger_bin = "gdb"
  end
  return debugger_bin
end

local function define_config_ccpp()
  local os_name = vim.uv.os_uname().sysname

  if os_name == "Windows_NT" then
    dap.adapters.codelldb = {
      type = "executable",
      command = find_debugger(),
    }
    dap.configurations.cpp = {
      {
        name = "Launch file",
        type = "codelldb",
        request = "launch",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
      },
    }
  elseif os_name == "Darwin" then
    dap.adapters.lldb = {
      type = "executable",
      command = find_debugger(),
      name = "lldb",
    }
    dap.configurations.cpp = {
      {
        name = "Launch",
        type = "lldb",
        request = "launch",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        args = {},
      },
    }
  elseif os_name == "Linux" then
    dap.adapters.gdb = {
      type = "executable",
      command = find_debugger(),
      args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
    }
    dap.configurations.cpp = {
      {
        name = "Launch",
        type = "gdb",
        request = "launch",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        args = {}, -- provide arguments if needed
        cwd = "${workspaceFolder}",
        stopAtBeginningOfMainSubprogram = false,
      },
      {
        name = "Select and attach to process",
        type = "gdb",
        request = "attach",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        pid = function()
          local name = vim.fn.input("Executable name (filter): ")
          return require("dap.utils").pick_process({ filter = name })
        end,
        cwd = "${workspaceFolder}",
      },
      {
        name = "Attach to gdbserver :1234",
        type = "gdb",
        request = "attach",
        target = "localhost:1234",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
      },
    }
  end
  dap.configurations.c = dap.configurations.cpp
  dap.configurations.rust = dap.configurations.cpp
end

define_config_ccpp()

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

local dap_icons = {
  Breakpoint = { text = "", texthl = "Blue", linehl = "", numhl = "" },
  BreakpointCondition = { text = "󰮍", texthl = "Green", linehl = "", numhl = "" },
  BreakpointRejected = { text = "󰃤", texthl = "Red", linehl = "", numhl = "" },
  LogPoint = { text = "󰰐", texthl = "Blue", linehl = "", numhl = "" },
  Stopped = { text = "󰁕", texthl = "Red", linehl = "DiagnosticWarn", numhl = "" },
}

for name, config in pairs(dap_icons) do
  vim.fn.sign_define("Dap" .. name, config)
end
