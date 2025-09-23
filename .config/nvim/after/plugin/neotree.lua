local function open_with_window_picker(state)
    local node = state.tree:get_node()
    if not node then return end

    local picker = require('window-picker')
    local winid = picker.pick_window({ include_current_win = false })
    if not winid then
        -- fallback to default open if user cancels
        require('neo-tree.sources.filesystem.commands').open(state)
        return
    end

    vim.api.nvim_set_current_win(winid)
    -- Delegate to neo-tree's open command (respects config)
    require('neo-tree.sources.filesystem.commands').open(state)
end

require('neo-tree').setup {
    close_if_last_window = true,
    filesystem = {
        hijack_netrw_behavior = "open_current",
        filtered_items = {
            visible = true,
            hide_dotfiles = true,
            hide_gitignored = true
        }
    },
    window = {
        mappings = {
            ["w"] = open_with_window_picker,
        },
    },
}

vim.cmd[[highlight NeotreeCursorline guibg=#3a3942]]

vim.keymap.set("n", "<leader>fe", function()
    vim.cmd.Neotree("filesystem", "show", "current", "reveal")
end)

vim.keymap.set("n", "<leader>fE", function()
    vim.cmd.Neotree("filesystem", "show")
end)

vim.keymap.set("n", "<leader>fb", function()
    vim.cmd.Neotree("buffers", "current")
end)

vim.keymap.set("n", "<leader>fg", function()
    vim.cmd.Neotree("git_status", "current")
end)
