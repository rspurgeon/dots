require('gitsigns').setup()
vim.keymap.set("n", "<leader>gt", function()
    vim.cmd.Gitsigns("toggle_signs")
end)
