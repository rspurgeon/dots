require('telescope').setup {
    defaults = {
        vimgrep_arguments = {
            'rg',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case',
            '-u'
        }
    }
}

local builtin = require('telescope.builtin')
-- (f)ile -> (f)ind
vim.keymap.set('n', '<leader>ff', function()
    builtin.find_files( { hidden = true} )
end)

vim.keymap.set("n", "<leader>fe", function()
    vim.cmd.Neotree("filesystem", "toggle", "show", "left", "reveal")
end)
-- (f)ile -> (g)it -> (f)ind
vim.keymap.set('n', '<leader>fgf', builtin.git_files, {})
-- (f)ile -> (s)earch 
vim.keymap.set('n', '<leader>fs', builtin.live_grep, {})

