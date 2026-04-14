local ok, hop = pcall(require, 'hop')
if not ok then
    return
end

hop.setup {
    keys = 'etovxqpdygfblzhckisuran'
}

-- local directions = require('hop.hint').HintDirection
vim.keymap.set('n', '<leader> ', function()
	hop.hint_words()
end)
