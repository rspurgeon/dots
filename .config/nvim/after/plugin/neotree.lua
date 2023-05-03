require('neo-tree').setup {
    close_if_last_window = true,
    filesystem = {
        hijack_netrw_behavior = "open_current",
        filtered_items = {
            visible = true,
            hide_dotfiles = false,
            hide_gitignored = false
        }
    },
}

vim.cmd[[highlight NeotreeCursorline guibg=#3a3942]]

vim.keymap.set("n", "<leader>fe", function()
    vim.cmd.Neotree("filesystem", "show", "current", "reveal")
end)

vim.keymap.set("n", "<leader>fb", function()
    vim.cmd.Neotree("buffers", "current")
end)

vim.keymap.set("n", "<leader>fg", function()
    vim.cmd.Neotree("git_status", "current")
end)
