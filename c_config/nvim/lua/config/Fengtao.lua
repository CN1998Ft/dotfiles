local M = {}
local mini_pick = require("mini.pick")

-- NOTE1: harpoon not working with vim.pack.add yet
local function harpoon_pick_menu()
  vim.pack.add("harpoon")
  local ok, harpoon = pcall(require, "harpoon")
  print(ok)
  harpoon:setup({})

  local items = {}
  local harpoon_list = harpoon:list()
  for _, file in ipairs(harpoon_list.items) do
    table.insert(items, file.value)
  end

  mini_pick.start({
    source = {
      items = items,
      name = "󰛢 Harpoon",
      show = function(buf_id, items, query)
        return mini_pick.default_show(buf_id, items, query, { show_icons = true })
      end,
    },
  })
end

local function restart_session()
  local data_path = vim.fn.stdpath("data")
  local project_name = vim.fs.basename(vim.fn.getcwd())
  local session_path = vim.fs.normalize(data_path .. "/Sessions")
  if vim.fn.isdirectory(session_path) == 0 then
    vim.fn.mkdir(session_path)
  end
  local session_file = vim.fs.normalize(session_path .. "/" .. project_name .. ".vim")
  vim.cmd("mksession!" .. session_file)
  vim.cmd("restart source " .. session_file)
end

local function pick_config()
  local items = {}
  for name, _ in vim.fs.dir(vim.fn.stdpath("config"), { depth = 4 }) do
    local temp_file = vim.fn.stdpath("config") .. "/" .. name
    local file = vim.fs.normalize(temp_file)
    if vim.fn.isabsolutepath(file) == 1 then
      table.insert(items, file)
    end
  end

  mini_pick.start({
    source = {
      items = items,
      name = " config",
      show = function(buf_id, items, query)
        return mini_pick.default_show(buf_id, items, query, { show_icons = true })
      end,
    },
  })
end

local function pick_dir_file()
  local cwd = vim.uv.cwd()
  local items = {}
  local iterators = vim.fs.dir(cwd, { depth = 10 })
  for name, _ in iterators do
    local file = vim.fs.normalize(name)
    table.insert(items, file)
  end
  mini_pick.start({
    source = {
      items = items,
      name = "󰙅 dirs & files",
      show = function(buf_id, items, query)
        return mini_pick.default_show(buf_id, items, query, { show_icons = true })
      end,
    },
  })
end

-- Find in custom path
local function pick_in_custom_path()
  -- Prompt the user for the target path
  vim.ui.input({
    prompt = "Grep in path: ",
    default = vim.uv.os_homedir() .. "/",
    completion = "file",
  }, function(input)
    if not input or input == "" then
      print("Grep cancelled")
      return
    end

    if vim.fn.isdirectory(input) == 0 then
      vim.notify("Directory does not exist: " .. input, vim.log.levels.INFO)
      return
    end

    -- local items = {}
    -- local iterators = vim.fs.dir(input, { depth = 10 })
    -- for name, _ in iterators do
    --   local file = vim.fs.normalize(name)
    --   table.insert(items, file)
    -- end
    mini_pick.builtin.start({
      source = {
        items = { "rg", "--files", input },
        name = "󰮮 Grep source file",
        show = function(buf_id, items, query)
          return mini_pick.default_show(buf_id, items, query, { show_icons = true })
        end,
      },
    })
  end)
end

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

-- define the compilation for c/cpp
local function compile_c()
  if vim.fn.has("win32") == 1 and vim.uv.fs_stat("./build.ps1") ~= nil then
    vim.cmd("!pwsh ./build.ps1")
  elseif
    vim.fn.executable("make") == 1 and (vim.uv.fs_stat("./makefile") ~= nil or vim.uv.fs_stat("./Makefile") ~= nil)
  then
    vim.cmd("!make")
  elseif vim.fn.has("win32") == 0 and vim.uv.fs_stat("./build")["type"] == "file" then
    vim.cmd("!bash ./build")
  else
    vim.notify("No c/cpp build tools specified", vim.log.levels.INFO, {})
  end
end

-- execute the current file
local function execute_file()
  local filetype = vim.bo.filetype
  local file_to_execute = vim.fn.expand("%")
  local executor
  local string_msg = "Skipping the execution for filetype: " .. filetype
  if filetype == "python" then
    executor = find_python()
  elseif filetype == "lua" then
    executor = "luajit"
  elseif filetype == "sh" then
    executor = "bash"
  elseif filetype == "ps1" then
    if vim.fn.has("win32") == 0 then
      print(string_msg)
      return
    end
    executor = "pwsh"
  elseif filetype == "c" or filetype == "cpp" then
    compile_c()
    return
  else
    vim.notify(string_msg, vim.log.levels.INFO, {})
    return
  end
  vim.cmd("!" .. executor .. " " .. file_to_execute)
end

M.harpoon_pick_menu = harpoon_pick_menu
M.pick_config = pick_config
M.pick_dir_file = pick_dir_file
M.pick_in_custom_path = pick_in_custom_path
M.restart_session = restart_session
M.find_python = find_python
M.execute_file = execute_file

return M
