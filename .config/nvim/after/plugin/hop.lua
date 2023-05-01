local hop = require('hop')

-- local directions = require('hop.hint').HintDirection
vim.keymap.set('n', ' ', function()
	hop.hint_words()
end)
