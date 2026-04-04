-- Options for nvim
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 10

-- Tab settings:
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

-- Cursor
vim.opt.guicursor = {
    "n-c-v-t:block",
    "i-ci:ver25",
    "r-cr:hor40",
}
vim.opt.cursorline = true

-- Add column ruler at 80
vim.opt.colorcolumn = "80"

-- Miscellaneous
vim.opt.showmode = false
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Set the terminal shell for nvim, this may not be used
if vim.fn.has("win64") == 1 or vim.fn.has("win32") == 1 then
    local powershell_options = {
            shell = vim.fn.executable("pwsh") == 1 and "pwsh" or "powershell",
            shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;",
            shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait",
            shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; if($?) { cat %s } : echo $null",
            shellquote = "",
            shellxquote = "",
        }

        for option, value in pairs(powershell_options) do
            vim.opt[option] = value
        end
elseif vim.fn.has("Darwin") == 1 then
    vim.o.shell = "/bin/zsh"
elseif vim.fn.has("Linux") == 1 then
    vim.o.shell = "/usr/bin/bash"
end

-- Undodir and undofile
local undodir = vim.fn.stdpath("data") .. "/undo"

if vim.fn.isdirectory(undodir) == 0 then
    vim.fn.mkdir(undodir, "p")
end

vim.opt.undodir = undodir
vim.opt.undofile = true
