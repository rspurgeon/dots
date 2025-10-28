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
            --'-u',
        }
    }
}

-- require('telescope').load_extension('bookmarks')

local builtin = require('telescope.builtin')
-- (f)ile -> (f)ind
vim.keymap.set('n', '<leader>ff', function()
    builtin.find_files()
end, { noremap = true, silent = true })

-- (f)ile -> (g)it -> (f)ind
vim.keymap.set('n', '<leader>fgf', builtin.git_files, { noremap = true, silent = true })

local telescope = require('telescope.builtin')

local function grep_all()
  telescope.live_grep({
    additional_args = function()
      return { '--hidden', '--no-ignore' }
    end,
  })
end

local function grep_clean()
  telescope.live_grep({
    additional_args = function()
      return { '--hidden', '--glob', '!**/node_modules/**' }
    end,
  })
end

vim.keymap.set('n', '<leader>fa', grep_all, { noremap = true, silent = true })   -- "find all"
vim.keymap.set('n', '<leader>fs', grep_clean, { noremap = true, silent = true }) -- "find clean"

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

