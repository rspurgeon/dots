function ColorMyPencils(color)
	color = color or "gruvbox"
	vim.cmd.colorscheme(color)
    vim.cmd('highlight VertSplit guifg=#0b88e0')
    vim.cmd('highlight NonText guifg=#0b88e0')
end

ColorMyPencils("gruvbox")
