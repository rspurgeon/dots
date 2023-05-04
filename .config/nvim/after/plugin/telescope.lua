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

-- (f)ile -> (g)it -> (f)ind
vim.keymap.set('n', '<leader>fgf', builtin.git_files, {})
-- (f)ile -> (s)earch 
vim.keymap.set('n', '<leader>fs', builtin.live_grep, {})

-- (f)ile -> (c)ommand history
vim.keymap.set('n', '<leader>fc', builtin.command_history, {})

-- (f)ile -> (h)ome
vim.keymap.set("n", "<Leader>fh", function()
    require('telescope.builtin').find_files({
        prompt_title = "< Home >",
        cwd = "~",
        file_ignore_patterns = {
            'Applications', 'Library',
        },
        hidden = true,
    })
end, { noremap = true, silent = true })

