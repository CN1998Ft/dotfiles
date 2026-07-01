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
      vim.log.levels.ERROR,
      { title = "Nvim-DAP" }
    )
    python_bin = nil
  end
  return python_bin
end

local function get_c_compile_cmd()
  if vim.fn.has("win32") == 1 and vim.uv.fs_stat("./build.bat") ~= nil then
    return { "build.bat" }
  elseif vim.fn.has("win32") == 1 and vim.uv.fs_stat("./build.ps1") ~= nil then
    return { "pwsh", "./build.ps1" }
  elseif
    vim.fn.executable("make") == 1 and (vim.uv.fs_stat("./makefile") ~= nil or vim.uv.fs_stat("./Makefile") ~= nil)
  then
    return { "make" }
  elseif vim.fn.has("win32") == 0 and vim.uv.fs_stat("./build.sh") ~= nil then
    return { "bash", "./build.sh" }
  else
    return nil
  end
end

-- execute the current file
local function execute_file()
  -- local variable initialisation
  local filetype = vim.bo.filetype
  -- local file_to_execute = vim.fs.normalize(vim.fn.expand("%"))
  local file_to_execute = vim.fn.fnamemodify(vim.fn.expand("%"), ".")
  local cmd = nil
  local string_msg = "  Skipping the execution for filetype: " .. filetype
  local fail_msg = " Build Execution Failed!  "
  local efm = vim.o.errorformat
  local efm_python = [[  File "%f"\, line %l\, in %m]] .. "," .. [[  File "%f"\, line %l%.%#]]
  local efm_bash = [[%f: line %l: %m]]
  local efm_pwsh = [[%A%*[^:]:\ %f:%l,%+C%.%#]]

  -- filetype specific cmd and error message format.
  if filetype == "python" then
    local python_bin = find_python()
    if not python_bin then
      vim.notify(fail_msg, vim.log.levels.ERROR, {})
      return
    end
    cmd = { python_bin, file_to_execute }
    efm = efm_python
  elseif filetype == "lua" then
    cmd = { "luajit", file_to_execute }
  elseif filetype == "sh" then
    cmd = { "bash", file_to_execute }
    efm = efm_bash
  elseif filetype == "ps1" then
    if vim.fn.has("win32") == 0 then
      vim.notify(string_msg, vim.log.levels.ERROR, {})
      return
    end
    cmd = { "pwsh", "-File", file_to_execute }
    efm = efm_pwsh
  elseif filetype == "dosbatch" then
    if vim.fn.has("win32") == 0 then
      vim.notify(string_msg, vim.log.levels.ERROR, {})
      return
    end
    cmd = { file_to_execute }
  elseif filetype == "c" or filetype == "cpp" then
    cmd = get_c_compile_cmd()
    if not cmd then
      vim.notify("  No c/cpp build tool specified!", vim.log.levels.ERROR, {})
      return
    end
    if cmd[1] == "pwsh" then
      efm = efm_pwsh .. "," .. vim.o.errorformat
    elseif cmd[1] == "bash" then
      efm = efm_bash .. "," .. vim.o.errorformat
    end
  else
    vim.notify(string_msg, vim.log.levels.ERROR, {})
    return
  end

  vim.fn.setqflist({}, "r")
  vim.notify("  Executing Build...", vim.log.levels.WARN, {})

  local final_cmd = cmd
  if vim.fn.has("win32") == 1 then
    final_cmd = vim.list_extend({ "cmd.exe", "/c" }, cmd)
  end

  vim.system(final_cmd, { text = true }, function(obj)
    vim.schedule(function()
      local output = ""
      if obj.stdout and obj.stdout ~= "" then
        output = output .. obj.stdout .. "\n"
      end
      if obj.stderr and obj.stderr ~= "" then
        output = output .. obj.stderr
      end

      if vim.fn.has("win32") == 1 then
        output = output:gsub("\r", "")
        output = output:gsub("\27%[[%d;]*%a", "")
      end

      local lines = vim.split(output, "\n")
      while #lines > 0 and lines[#lines] == "" do
        table.remove(lines)
      end

      vim.fn.setqflist({}, "r", {
        title = table.concat(cmd, " "),
        lines = lines,
        efm = efm,
      })

      if #lines > 0 then
        vim.cmd("copen")
        vim.notify("  Execution done, check if any errors.  ", vim.log.levels.INFO, {})
      else
        vim.notify("  Execution Successful, not stdout  ", vim.log.levels.INFO, {})
        vim.cmd("cclose")
      end
    end)
  end)
end

M.harpoon_pick_menu = harpoon_pick_menu
M.pick_config = pick_config
M.pick_dir_file = pick_dir_file
M.restart_session = restart_session
M.find_python = find_python
M.execute_file = execute_file

return M
