return {
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")

      -- ADAPTER SETUP
      dap.adapters.python = function(cb, config)
        if config.request == "attach" then
          local port = (config.connect or config).port
          local host = (config.connect or config).host or "127.0.0.1"
          cb({
            type = "server",
            port = assert(port, "`connect.port` is required for python `attach`"),
            host = host,
            options = { source_filetype = "python" },
          })
        else
          cb({
            type = "executable",
            -- PATH FIX: Point this to your PhD environment python
            command = "C:\\Users\\93581\\miniforge3\\envs\\phd\\python.exe",
            args = { "-m", "debugpy.adapter" },
            options = { source_filetype = "python" },
          })
        end
      end

      -- CONFIGURATION SETUP
      dap.configurations.python = {
        {
          type = "python",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          pythonPath = function()
            -- Automatically find the python in your current project or use PhD env
            local cwd = vim.fn.getcwd()
            if vim.fn.executable(cwd .. "\\venv\\Scripts\\python.exe") == 1 then
              return cwd .. "\\venv\\Scripts\\python.exe"
            elseif vim.fn.executable(cwd .. "\\.venv\\Scripts\\python.exe") == 1 then
              return cwd .. "\\.venv\\Scripts\\python.exe"
            else
              -- Default back to your main research environment
              return "C:\\Users\\93581\\miniforge3\\envs\\phd\\python.exe"
            end
          end,
        },
      }
    end,
  },
}
