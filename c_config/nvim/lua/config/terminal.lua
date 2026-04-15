local M = {}
local terminal_state = { buf = nil, win = nil, is_open = false}

local function FloatingTerminal()
    if terminal_state.is_open and terminal_state.win and vim.nvim_win_is_valid(terminal_state.win) then
        vim.api.nvim_win_close(terminal_state.win, false)
        terminal_state.is_open = false
        return
    end

    if not terminal_state.buf or not vim.api.nvim_buf_is_valid(terminal_state.buf) then
        terminal_state.buf  = vim.api.nvim_create_buf(false, true)
    end

    local width = vim.o.columns
    local height = math.floor(vim.o.lines * 0.3)
    local row = math.floor(vim.o.lines * 0.6)
    local col = 0

    terminal_state.win = vim.api.nvim_open_win(terminal_state.buf, true, {
        relative = "editor",
        width = width,
        height = height,
        row = row,
        col = col,
        style = "minimal",
        border = "single",
    })

    vim.wo[terminal_state.win].winblend = 0
    vim.wo[terminal_state.win].winhighlight = "Normal:FloatingTermNormal,FloatBorder:FloatingTermBorder"
    vim.api.nvim_set_hl(0, "FloatingTermNormal", {bg = "none"})
    vim.api.nvim_set_hl(0, "FloatingTermBorder", {bg = "none"})

    local has_terminal = false
    local lines = vim.api.nvim_buf_get_lines(terminal_state.buf, 0, -1, false)
    for _, line in pairs(lines) do
        if line ~= "" then
            has_terminal = true
            break
        end
    end
    if not has_terminal then
        vim.fn.termopen(vim.o.shell)
    end

    terminal_state.is_open = true
    vim.cmd("startinsert")

    vim.api.nvim_create_autocmd("BufLeave", {
        buffer = terminal_state.buf,
        callback = function()
            if terminal_state.is_open and terminal_state.win and vim.api.nvim_win_is_valid(terminal_state.win) then
                vim.api.nvim_win_close(terminal_state.win, false)
                terminal_state.is_open = false
            end
        end,
        once = true,
    })

end

local function termClose()
    if terminal_state.is_open and terminal_state.win and vim.api.nvim_win_is_valid(terminal_state.win) then
        vim.api.nvim_win_close(terminal_state.win, false)
        terminal_state.is_open = false
    end
end

M = {
    termOpen = FloatingTerminal,
    -- terminal_state = terminal_state, -- This is actually not used
    termClose = termClose,
}
return M
