local hop = require('hop')

hop.setup {
    keys = 'etovxqpdygfblzhckisuran'
}

-- local directions = require('hop.hint').HintDirection
vim.keymap.set('n', '<leader> ', function()
	hop.hint_words()
end)
