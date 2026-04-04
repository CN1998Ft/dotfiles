local M = {}

local function example()
    vim.cmd([[echo "hello"]])
end

local function harpoon_pick_menu()
    local ok, harpoon = pcall(require, "harpoon")
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
            choose = function(item)
                vim.api.nvim_win_call(
                MiniPick.get_picker_state().windows.target,
                function() vim.cmd('edit ' .. item) end
                )
            end,
            preview = function(buf_id, item)
                local lines = vim.fn.readfile(vim.fn.expand(item))
                vim.api.nvim_buf_set_lines(buf_id, 0, -1, false, lines)
                local ft = vim.filetype.match({ filename = item })
                if ft then
                    vim.bo[buf_id].syntax = ft
                end
            end,
            show = function(buf_id, items, query)
                return MiniPick.default_show(buf_id, items, query, {show_icons = true})
            end,
        },
    })
end

local function pick_config()
    local items = {}
    local show_items = {}
    for name, _ in vim.fs.dir(vim.fn.stdpath("config"), {depth = 4}) do
        if vim.fn.isdirectory(name) then
            temp_name = vim.fs.normalize(name)
            table.insert(show_items, temp_name)
        end
        temp_file = vim.fn.stdpath("config") .. "/" .. name
        file = vim.fs.normalize(temp_file)
        if vim.fn.isdirectory(file) == 0 and vim.fn.isabsolutepath(file) then
            table.insert(items, file)
        end
    end

    -- MiniPick.start({ source = { items = vim.fn.readdir(".") }})
    MiniPick.start({
        source = {
            items = items,
            name = "config",
            -- cwd = vim.fn.stdpath("config"),
            choose = function(item)
                vim.api.nvim_win_call(
                    MiniPick.get_picker_state().windows.target,
                    function() vim.cmd('edit ' .. item) end
                )
            end,
            preview = function(buf_id, item)
                local lines = vim.fn.readfile(vim.fn.expand(item))
                vim.api.nvim_buf_set_lines(buf_id, 0, -1, false, lines)
                local ft = vim.filetype.match({ filename = item })
                if ft then
                    vim.bo[buf_id].syntax = ft
                end
            end,
            show = function(buf_id, items, query)
                return MiniPick.default_show(buf_id, items, query, {show_icons = true})
            end,
        },
    })
end

M.harpoon_pick_menu = harpoon_pick_menu
M.pick_config = pick_config

return M
