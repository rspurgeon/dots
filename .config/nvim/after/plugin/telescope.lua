local ok_telescope, telescope = pcall(require, 'telescope')
if not ok_telescope then
    return
end

telescope.setup {
    defaults = {
        vimgrep_arguments = {
            'rg',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case',
            --'-u',
        }
    }
}

-- Load fzf native extension for better fuzzy finding
telescope.load_extension('fzf')
telescope.load_extension('live_grep_args')

-- require('telescope').load_extension('bookmarks')

local builtin = require('telescope.builtin')
-- (f)ile -> (f)ind
vim.keymap.set('n', '<leader>ff', function()
    builtin.find_files()
end, { noremap = true, silent = true })

-- (f)ile -> (g)it -> (f)ind
vim.keymap.set('n', '<leader>fgf', builtin.git_files, { noremap = true, silent = true })

local live_grep_args = telescope.extensions.live_grep_args

vim.keymap.set('n', '<leader>fs', live_grep_args.live_grep_args, { noremap = true, silent = true })

-- (f)ile -> (c)ommand history
vim.keymap.set('n', '<leader>fc', builtin.command_history, { noremap = true, silent = true })

-- (f)ile -> (d)iagnostics
vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { noremap = true, silent = true })

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
