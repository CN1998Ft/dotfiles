-- Trailspace autorun
local trial_line_trim = vim.api.nvim_create_augroup("RemoveEmptyLineTrialSpace", { clear = true })

vim.api.nvim_create_autocmd('BufWrite', {
    desc = "Trim trail space after :w",
    group = trial_line_trim,
    callback = function()
        MiniTrailspace.trim()
        MiniTrailspace.trim_last_lines()
    end,
})


-- Cursor
local restore_cursor = vim.api.nvim_create_augroup("RestoreCursor", { clear = true })

vim.api.nvim_create_autocmd("BufReadPost", {
  group = restore_cursor,
  callback = function()
    local line = vim.fn.line("'\"")
    local last_line = vim.fn.line("$")
    local ft = vim.bo.filetype
    local is_diff = vim.wo.diff

    -- Logic: If the line is valid, not a commit/rebase/xxd, and not in diff mode
    if line >= 1 and line <= last_line and ft ~= "gitcommit"
       and ft ~= "xxd" and ft ~= "gitrebase" and not is_diff then
      vim.cmd('normal! g`"')
    end
  end,
})


-- term
local floatTerminal = vim.api.nvim_create_augroup("floatTerminal", { clear = true })

vim.api.nvim_create_autocmd("TermClose", {
    group = floatTerminal,
    callback = function()
        if vim.v.event.status == 0 then
            vim.api.nvim_buf_delete(0, {})
        end
    end,
})

vim.api.nvim_create_autocmd("TermOpen", {
    group = floatTerminal,
    callback = function()
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
        vim.opt_local.signcolumn = "no"
    end,
})


-- Highlight
local highlight_group = vim.api.nvim_create_augroup("highlight_group", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
    group = highlight_group,
    desc = "Highlight selection on yank",
    callback = function()
        vim.hl.on_yank()
    end,
})


-- Resize split when window is resized
local resize_split = vim.api.nvim_create_augroup("resize_split", { clear = true })

vim.api.nvim_create_autocmd("VimResized", {
    group = resize_split,
    desc = "Resize split when window is resized",
    callback = function()
        local current_tab = vim.fn.tabpagenr()
        vim.cmd("tabdo wincmd =")
        vim.cmd("tabnext " .. current_tab)
    end,
})


-- close certain filetypes with 'q'
local simple_q = vim.api.nvim_create_augroup("simple_q", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
    group = simple_q,
    pattern = {
        -- Not exhaustive, only the one that I use, copied from LazyVim.
        "checkhealth",
        "help",
    },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.schedule(function()
      vim.keymap.set("n", "q", function()
        vim.cmd("close")
        pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
      end, {
        buffer = event.buf,
        silent = true,
        desc = "Quit buffer",
      })
    end)
  end,
})

-- wrap and check for spell in text filetypes
local wrap_text = vim.api.nvim_create_augroup("wrap_text", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
    group = wrap_text,
    pattern = { "text", "plaintext", "typst", "gitcommit", "markdown", "tex", "bib"},
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
    end,
})


-- auto create dir when saving file without intermediate directory
local inter_dir = vim.api.nvim_create_augroup("inter_dir_create", { clear = true })

vim.api.nvim_create_autocmd("BufWritePre", {
    group = inter_dir,
    callback = function(event)
        if event.match:match("^%w%w+:[\\/][\\/]") then
            return
        end
        local file = vim.uv.fs_realpath(event.match) or event.match
        vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
    end,
})


-- lua file specific config
local lua_config = vim.api.nvim_create_augroup("lua_config", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
    group = lua_config,
    pattern = {"lua"},
    callback = function()
        vim.opt_local.tabstop = 2
        vim.opt_local.shiftwidth = 2
        vim.opt_local.softtabstop = 2
        vim.opt_local.colorcolumn = "100"
    end,
})
