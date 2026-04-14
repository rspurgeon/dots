vim.cmd("hi clear")
if vim.fn.exists("syntax_on") then
    vim.cmd("syntax reset")
end

vim.g.colors_name = "kong"
vim.o.termguicolors = true
vim.o.background = "dark"

local c = {
    bg = "#000F06",
    bg1 = "#081A0E",
    bg2 = "#101110",
    bg3 = "#2D2E2C",
    bg4 = "#4A4D49",
    fg = "#B7BDB5",
    fg1 = "#CDD4CB",
    gray = "#676B66",
    gray_lt = "#858983",
    lime = "#CCFF00",
    lime_dim = "#A3BE40",
    lime_br = "#DDFF55",
    teal = "#6B9E8A",
    teal_br = "#8CC4A8",
    sage = "#7DAF7D",
    rose = "#C4869B",
    rose_br = "#E3A6BB",
    red = "#E05F56",
}

local function hi(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
end

hi("Normal", { fg = c.fg, bg = c.bg })
hi("NormalFloat", { fg = c.fg, bg = c.bg1 })
hi("FloatBorder", { fg = c.lime, bg = c.bg1 })
hi("CursorLine", { bg = c.bg1 })
hi("CursorLineNr", { fg = c.lime, bold = true })
hi("LineNr", { fg = c.bg4 })
hi("VertSplit", { fg = c.bg4 })
hi("WinSeparator", { fg = c.bg4 })
hi("Visual", { bg = c.bg3 })
hi("Search", { fg = c.bg, bg = c.lime })
hi("IncSearch", { fg = c.bg, bg = c.lime_br })
hi("Pmenu", { fg = c.fg, bg = c.bg1 })
hi("PmenuSel", { fg = c.bg, bg = c.lime })
hi("Comment", { fg = c.gray, italic = true })
hi("Constant", { fg = c.rose })
hi("String", { fg = c.lime })
hi("Identifier", { fg = c.fg })
hi("Function", { fg = c.teal })
hi("Statement", { fg = c.lime_dim })
hi("Keyword", { fg = c.lime_dim })
hi("Operator", { fg = c.fg1 })
hi("Type", { fg = c.sage })
hi("Special", { fg = c.rose_br })
hi("Title", { fg = c.lime, bold = true })
hi("DiagnosticError", { fg = c.red })
hi("DiagnosticWarn", { fg = c.lime_dim })
hi("DiagnosticInfo", { fg = c.teal })
hi("DiagnosticHint", { fg = c.gray_lt })
hi("GitSignsAdd", { fg = c.lime })
hi("GitSignsChange", { fg = c.lime_dim })
hi("GitSignsDelete", { fg = c.red })
hi("TelescopeBorder", { fg = c.lime, bg = c.bg })
hi("TelescopePromptTitle", { fg = c.bg, bg = c.lime, bold = true })
hi("TelescopeSelection", { bg = c.bg2 })
hi("TelescopeMatching", { fg = c.lime_br, bold = true })
