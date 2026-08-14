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

-- Getting a table of cmd: table and efm: string
local function get_cmd_efm()
  local filetype = vim.bo.filetype
  local file_to_execute = vim.fn.fnamemodify(vim.fn.expand("%"), ".")
  local error_msg = "  Skipping the execution for filetype: " .. filetype
  local cmd = nil
  local efm = vim.o.errorformat
  local efm_python = [[  File "%f"\, line %l\, in %m]] .. "," .. [[  File "%f"\, line %l%.%#]]
  local efm_bash = [[%f: line %l: %m]]
  local efm_pwsh = [[%A%*[^:]:\ %f:%l,%+C%.%#]]
  local efm_lua = [[%*[^ ]\ %f:%l:\ %m]] .. "," .. [[%+Gstack\ traceback:]] .. "," .. [[%+G\ \ \ \ \ \ \ \ %.%#]]
  local cmd_efm_table = {} -- For packaging cmd and error message.

  -- filetype specific cmd and error message format.
  if filetype == "python" and vim.uv.fs_stat("./uv.lock") ~= nil then
    cmd = { "uv", "run", file_to_execute }
  elseif filetype == "python" and vim.uv.fs_stat("./uv.lock") == nil then
    local python_bin = find_python()
    if not python_bin then
      vim.notify(error_msg, vim.log.levels.ERROR, {})
      return nil
    end
    cmd = { python_bin, file_to_execute }
    efm = efm_python
  elseif filetype == "lua" then
    cmd = { "luajit", file_to_execute }
    efm = efm_lua
  elseif filetype == "sh" then
    cmd = { "bash", file_to_execute }
    efm = efm_bash
  elseif filetype == "ps1" then
    if vim.fn.has("win32") == 0 then
      vim.notify(error_msg, vim.log.levels.ERROR, {})
      return nil
    end
    cmd = { "pwsh", "-File", file_to_execute }
    efm = efm_pwsh
  elseif filetype == "dosbatch" then
    if vim.fn.has("win32") == 0 then
      vim.notify(error_msg, vim.log.levels.ERROR, {})
      return nil
    end
    cmd = { "cmd.exe", "/c", file_to_execute }
  elseif filetype == "c" or filetype == "cpp" then
    cmd = get_c_compile_cmd()
    if not cmd then
      vim.notify("  No c/cpp build tool specified!", vim.log.levels.ERROR, {})
      return nil
    end
    if cmd[1] == "pwsh" then
      efm = efm_pwsh .. "," .. vim.o.errorformat
    elseif cmd[1] == "bash" then
      efm = efm_bash .. "," .. vim.o.errorformat
    end
  else
    vim.notify(error_msg, vim.log.levels.ERROR, {})
    return nil
  end
  cmd_efm_table["cmd"] = cmd
  cmd_efm_table["efm"] = efm
  return cmd_efm_table
end

-- The execution call in command mode
local function execute_and_stdout(final_cmd, efm)
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
        title = table.concat(final_cmd, " "),
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

-- The execution call in nvim term
local function term_execute_and_stdout(final_cmd, efm)
  -- 1. Setup split layout: Vertical split -> terminal -> move to rightmost column
  vim.cmd("vsplit")
  vim.cmd("wincmd L")

  -- Create an unlisted scratch buffer
  local buf = vim.api.nvim_create_buf(false, true)
  local win = vim.api.nvim_get_current_win()
  vim.api.nvim_win_set_buf(win, buf)

  -- 2. CRITICAL FIX: Mark buffer as non-file so Ruff/LSP won't try to analyze it
  vim.bo[buf].buftype = "nofile"
  vim.bo[buf].bufhidden = "hide"
  vim.bo[buf].swapfile = false

  -- Disable LSP diagnostics on this terminal buffer
  vim.diagnostic.enable(false, { bufnr = buf })

  -- 3. Launch job via termopen
  local job_id = vim.fn.jobstart(final_cmd, {
    term = true,
    on_exit = function(_, exit_code, _)
      vim.schedule(function()
        -- Extract output lines directly from the terminal buffer
        local raw_lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
        local lines = {}

        -- Strip Windows CR and terminal ANSI escape codes for clean Quickfix parsing
        for _, line in ipairs(raw_lines) do
          local cleaned = line:gsub("\r", ""):gsub("\27%[[%d;]*%a", "")
          table.insert(lines, cleaned)
        end

        -- Remove trailing empty lines
        while #lines > 0 and lines[#lines] == "" do
          table.remove(lines)
        end

        -- Populate Quickfix list with the stripped lines and efm
        vim.fn.setqflist({}, "r", {
          title = table.concat(final_cmd, " "),
          lines = lines,
          efm = efm,
        })

        -- Check if efm parsed any errors/warnings into quickfix
        local qf_items = vim.fn.getqflist()

        if exit_code ~= 0 or #qf_items > 0 then
          vim.cmd("copen")
          vim.notify("  Execution finished with errors/output. Check Quickfix list.  ", vim.log.levels.WARN)
        else
          vim.notify("  Execution Successful!  ", vim.log.levels.INFO)
          vim.cmd("cclose")

          -- Automatically close the live terminal split if clean exit
          if vim.api.nvim_win_is_valid(win) then
            vim.api.nvim_win_close(win, true)
          end
        end
      end)
    end,
  })

  if job_id <= 0 then
    vim.notify("Failed to start job: " .. table.concat(final_cmd, " "), vim.log.levels.ERROR)
  end
end

-- execute the current file
local function execute_file(input_args, gui)
  -- local fail_msg = " Build Execution Failed!  "

  vim.fn.setqflist({}, "r")
  vim.notify("  Executing Build...", vim.log.levels.WARN, {})

  local cmd_efm_table = get_cmd_efm()
  if cmd_efm_table == nil then
    return
  end

  local final_cmd = vim.list_slice(cmd_efm_table.cmd)
  local efm = cmd_efm_table["efm"]

  if input_args and input_args ~= "" then
    local args_list = vim.split(input_args, "%s+", { trimempty = true })
    vim.list_extend(final_cmd, args_list)
  end

  if gui then
    term_execute_and_stdout(final_cmd, efm)
  else
    execute_and_stdout(final_cmd, efm)
  end
end

local function execute_file_with_args(gui)
  local cmd = get_cmd_efm().cmd
  local cmd_string

  for _, value in pairs(cmd) do
    cmd_string = (cmd_string or "") .. " " .. value
  end

  local prompt_indicator = nil
  if cmd_string then
    prompt_indicator = cmd_string .. " "
    vim.ui.input({ prompt = prompt_indicator }, function(input)
      execute_file(input, gui)
    end)
  end
end

M.harpoon_pick_menu = harpoon_pick_menu
M.pick_config = pick_config
M.pick_dir_file = pick_dir_file
M.restart_session = restart_session
M.find_python = find_python
M.execute_file = execute_file
M.execute_file_with_args = execute_file_with_args

return M
