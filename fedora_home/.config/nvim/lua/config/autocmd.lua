local my_group = vim.api.nvim_create_augroup("CustomSettings", { clear = true })

vim.api.nvim_create_autocmd('BufWrite', {
    desc = "Trim trail space after :w",
    group = my_group,
    callback = function()
        MiniTrailspace.trim()
        MiniTrailspace.trim_last_lines()
    end,
})

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
