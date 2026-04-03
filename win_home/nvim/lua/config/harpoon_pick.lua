local M = {}

local function example()
    vim.cmd([[echo "hello"]])
end

local function harpoon_pick_menu()
    local ok, harpoon = pcall(require, "harpoon")
    harpoon:setup({})

    local items = {}
    local harpoon_list = harpoon:list()
    for _, item in ipairs(harpoon_list.items) do
        table.insert(items, item.value)
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
        },
    })
end

M.harpoon_pick_menu = harpoon_pick_menu

return M
