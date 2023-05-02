vim.keymap.set("n", "<leader>fe", function()
    vim.cmd.Neotree("filesystem", "toggle", "show", "left", "reveal")
end)

vim.keymap.set("n", "<leader>fb", function()
    vim.cmd.Neotree("buffers")
end)

vim.keymap.set("n", "<leader>fg", function()
    vim.cmd.Neotree("git_status")
end)
