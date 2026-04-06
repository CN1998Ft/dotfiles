local M = {}

local function example()
    vim.cmd([[echo "hello"]])
end

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

    MiniPick.start({
        source = {
            items = items,
            name = "󰛢 Harpoon",
            -- choose = function(item)
            --     vim.api.nvim_win_call(
            --     MiniPick.get_picker_state().windows.target,
            --     function() vim.cmd('edit ' .. item) end
            --     )
            -- end,
            show = function(buf_id, items, query)
                return MiniPick.default_show(buf_id, items, query, {show_icons = true})
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
    for name, _ in vim.fs.dir(vim.fn.stdpath("config"), {depth = 4}) do
        temp_file = vim.fn.stdpath("config") .. "/" .. name
        file = vim.fs.normalize(temp_file)
        if vim.fn.isabsolutepath(file) == 1 then
            table.insert(items, file)
        end
    end

    MiniPick.start({
        source = {
            items = items,
            name = " config",
            -- cwd = vim.fn.stdpath("config"),
            -- choose = function(item)
            --     vim.api.nvim_win_call(
            --         MiniPick.get_picker_state().windows.target,
            --         function() vim.cmd('edit ' .. item) end
            --     )
            -- end,
            show = function(buf_id, items, query)
                return MiniPick.default_show(buf_id, items, query, {show_icons = true})
            end,
        },
    })
end

local function pick_dir_file()
    local cwd = vim.uv.cwd()
    local items = {}
    local iterators = vim.fs.dir(cwd, {depth = 10})
    for name, _ in iterators do
        file = vim.fs.normalize(name)
        table.insert(items, file)
    end
    MiniPick.start({
        source = {
            items = items,
            name = "󰙅 dirs & files",
            show = function(buf_id, items, query)
                return MiniPick.default_show(buf_id, items, query, {show_icons = true})
            end,
        },
    })
end

M.harpoon_pick_menu = harpoon_pick_menu
M.pick_config = pick_config
M.pick_dir_file = pick_dir_file
M.restart_session = restart_session

return M
