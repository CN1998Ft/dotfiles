return {
    "mfussenegger/nvim-dap-python",
    config = function()
        local home = "C:\\Users\\"
        local user = vim.fn.expand("$USERNAME")
        local debug_python = home .. user .. "\\miniforge3\\envs\\phd\\python.exe"
        require("dap-python").setup(debug_python)
        -- require("dap-python").resolve_python()
        require("dap-python").test_runner = "pytest"
    end,
}
