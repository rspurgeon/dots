local builtin = require('telescope.builtin')
-- (f)ile -> (f)ind
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
-- (f)ile -> (g)it -> (f)ind
vim.keymap.set('n', '<leader>fgf', builtin.git_files, {})
-- (f)ile -> (s)earch 
vim.keymap.set('n', '<leader>fs', builtin.live_grep, {})

