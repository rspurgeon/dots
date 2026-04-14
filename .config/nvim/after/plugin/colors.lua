function ColorMyPencils(color)
	color = color or "kong"
	vim.cmd.colorscheme(color)
end

ColorMyPencils("kong")
