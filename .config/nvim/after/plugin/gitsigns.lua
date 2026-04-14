local ok, gitsigns = pcall(require, 'gitsigns')
if not ok then
    return
end

gitsigns.setup()
vim.keymap.set("n", "<leader>gt", function()
    vim.cmd.Gitsigns("toggle_signs")
end)
