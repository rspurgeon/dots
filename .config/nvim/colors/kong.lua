vim.cmd("hi clear")
if vim.fn.exists("syntax_on") then
    vim.cmd("syntax reset")
end

vim.g.colors_name = "kong"
vim.o.termguicolors = true
vim.o.background = "dark"

-- Kong brand palette
local c = {
    bg        = "#000F06",
    bg1       = "#081A0E",
    bg2       = "#101110",
    bg3       = "#2D2E2C",
    bg4       = "#4A4D49",

    fg        = "#B7BDB5",
    fg1       = "#CDD4CB",
    fg2       = "#D7DED4",
    fg3       = "#E7EDE5",

    gray      = "#676B66",
    gray_lt   = "#858983",
    gray_dk   = "#4A4D49",

    lime      = "#CCFF00",  -- electric lime (primary accent)
    lime_dim  = "#A3BE40",  -- muted lime
    lime_br   = "#DDFF55",  -- bright lime

    teal      = "#6B9E8A",  -- functions
    teal_br   = "#8CC4A8",  -- bright teal

    sage      = "#7DAF7D",  -- types
    sage_br   = "#A3D4A0",  -- bright sage

    rose      = "#C4869B",  -- constants, special
    rose_br   = "#E3A6BB",  -- bright rose

    red       = "#E05F56",  -- errors
    red_br    = "#FF8785",  -- bright red

    none      = "NONE",
}

local function hi(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
end

-- Editor UI
hi("Normal",        { fg = c.fg, bg = c.bg })
hi("NormalFloat",   { fg = c.fg, bg = c.bg1 })
hi("NormalNC",      { fg = c.fg, bg = c.bg })
hi("FloatBorder",   { fg = c.lime, bg = c.bg1 })
hi("FloatTitle",    { fg = c.lime, bg = c.bg1, bold = true })
hi("Cursor",        { fg = c.bg, bg = c.lime })
hi("CursorLine",    { bg = c.bg1 })
hi("CursorLineNr",  { fg = c.lime, bold = true })
hi("CursorColumn",  { bg = c.bg1 })
hi("ColorColumn",   { bg = c.bg1 })
hi("LineNr",        { fg = c.gray_dk })
hi("SignColumn",    { bg = c.bg })
hi("VertSplit",     { fg = c.gray_dk })
hi("WinSeparator",  { fg = c.gray_dk })
hi("StatusLine",    { fg = c.fg, bg = c.bg2 })
hi("StatusLineNC",  { fg = c.gray, bg = c.bg2 })
hi("MsgArea",       { fg = c.fg, bg = c.bg2 })
hi("MsgSeparator",  { fg = c.gray_dk, bg = c.bg2 })
hi("TabLine",       { fg = c.fg, bg = c.bg2 })
hi("TabLineFill",   { bg = c.bg2 })
hi("TabLineSel",    { fg = c.bg, bg = c.teal, bold = true })
hi("WinBar",        { fg = c.fg, bg = c.bg2 })
hi("WinBarNC",      { fg = c.gray, bg = c.bg2 })

-- Selections and search
hi("Visual",        { bg = c.bg3 })
hi("VisualNOS",     { bg = c.bg3 })
hi("Search",        { fg = c.bg, bg = c.lime })
hi("IncSearch",     { fg = c.bg, bg = c.lime_br })
hi("CurSearch",     { fg = c.bg, bg = c.lime_br, bold = true })
hi("Substitute",    { fg = c.bg, bg = c.rose })

-- Popup menu
hi("Pmenu",         { fg = c.fg, bg = c.bg1 })
hi("PmenuSel",      { fg = c.bg, bg = c.lime })
hi("PmenuSbar",     { bg = c.bg2 })
hi("PmenuThumb",    { bg = c.gray_dk })

-- Messages and diagnostics
hi("ErrorMsg",      { fg = c.red, bold = true })
hi("WarningMsg",    { fg = c.lime_dim, bold = true })
hi("MoreMsg",       { fg = c.lime })
hi("ModeMsg",       { fg = c.lime, bold = true })
hi("Question",      { fg = c.lime })

-- Diff
hi("DiffAdd",       { bg = "#0A2010" })
hi("DiffChange",    { bg = "#1A1A00" })
hi("DiffDelete",    { fg = c.red, bg = "#1A0A08" })
hi("DiffText",      { bg = "#2A2A00" })

-- Folding, special chars
hi("Folded",        { fg = c.gray, bg = c.bg1 })
hi("FoldColumn",    { fg = c.gray_dk, bg = c.bg })
hi("NonText",       { fg = c.bg3 })
hi("SpecialKey",    { fg = c.bg3 })
hi("Whitespace",    { fg = c.bg3 })
hi("EndOfBuffer",   { fg = c.bg })

-- Misc UI
hi("Directory",     { fg = c.lime })
hi("Title",         { fg = c.lime, bold = true })
hi("MatchParen",    { fg = c.lime_br, bg = c.bg3, bold = true })
hi("Conceal",       { fg = c.gray })
hi("WildMenu",      { fg = c.bg, bg = c.lime })

-- Syntax: core groups
hi("Comment",       { fg = c.gray, italic = true })
hi("Constant",      { fg = c.rose })
hi("String",        { fg = c.lime })
hi("Character",     { fg = c.lime })
hi("Number",        { fg = c.rose })
hi("Boolean",       { fg = c.rose })
hi("Float",         { fg = c.rose })

hi("Identifier",    { fg = c.fg })
hi("Function",      { fg = c.teal })

hi("Statement",     { fg = c.lime_dim })
hi("Conditional",   { fg = c.lime_dim })
hi("Repeat",        { fg = c.lime_dim })
hi("Label",         { fg = c.lime_dim })
hi("Operator",      { fg = c.fg1 })
hi("Keyword",       { fg = c.lime_dim })
hi("Exception",     { fg = c.red })

hi("PreProc",       { fg = c.sage })
hi("Include",       { fg = c.sage })
hi("Define",        { fg = c.sage })
hi("Macro",         { fg = c.sage })
hi("PreCondit",     { fg = c.sage })

hi("Type",          { fg = c.sage })
hi("StorageClass",  { fg = c.sage })
hi("Structure",     { fg = c.sage })
hi("Typedef",       { fg = c.sage })

hi("Special",       { fg = c.rose_br })
hi("SpecialChar",   { fg = c.rose_br })
hi("Tag",           { fg = c.lime_dim })
hi("Delimiter",     { fg = c.fg })
hi("SpecialComment",{ fg = c.gray_lt, italic = true })
hi("Debug",         { fg = c.red })

hi("Underlined",    { fg = c.teal, underline = true })
hi("Ignore",        { fg = c.gray_dk })
hi("Error",         { fg = c.red, bold = true })
hi("Todo",          { fg = c.lime, bg = c.bg2, bold = true })

-- Treesitter
hi("@variable",           { fg = c.fg })
hi("@variable.builtin",   { fg = c.rose })
hi("@variable.parameter", { fg = c.fg1 })
hi("@variable.member",    { fg = c.fg })
hi("@constant",           { fg = c.rose })
hi("@constant.builtin",   { fg = c.rose })
hi("@module",             { fg = c.sage })
hi("@string",             { fg = c.lime })
hi("@string.escape",      { fg = c.lime_dim })
hi("@string.regex",       { fg = c.lime_dim })
hi("@character",          { fg = c.lime })
hi("@number",             { fg = c.rose })
hi("@boolean",            { fg = c.rose })
hi("@float",              { fg = c.rose })
hi("@function",           { fg = c.teal })
hi("@function.builtin",   { fg = c.teal_br })
hi("@function.call",      { fg = c.teal })
hi("@function.method",    { fg = c.teal })
hi("@constructor",        { fg = c.sage })
hi("@keyword",            { fg = c.lime_dim })
hi("@keyword.function",   { fg = c.lime_dim })
hi("@keyword.return",     { fg = c.lime_dim })
hi("@keyword.operator",   { fg = c.lime_dim })
hi("@operator",           { fg = c.fg1 })
hi("@punctuation",        { fg = c.fg })
hi("@punctuation.bracket", { fg = c.fg })
hi("@punctuation.delimiter", { fg = c.fg })
hi("@comment",            { fg = c.gray, italic = true })
hi("@type",               { fg = c.sage })
hi("@type.builtin",       { fg = c.sage })
hi("@type.definition",    { fg = c.sage })
hi("@attribute",          { fg = c.lime_dim })
hi("@property",           { fg = c.fg })
hi("@tag",                { fg = c.lime_dim })
hi("@tag.attribute",      { fg = c.teal })
hi("@tag.delimiter",      { fg = c.gray })

-- LSP semantic tokens
hi("@lsp.type.function",  { fg = c.teal })
hi("@lsp.type.method",    { fg = c.teal })
hi("@lsp.type.parameter", { fg = c.fg1 })
hi("@lsp.type.variable",  { fg = c.fg })
hi("@lsp.type.property",  { fg = c.fg })
hi("@lsp.type.namespace", { fg = c.sage })
hi("@lsp.type.type",      { fg = c.sage })
hi("@lsp.type.enum",      { fg = c.sage })
hi("@lsp.type.interface", { fg = c.sage })
hi("@lsp.type.struct",    { fg = c.sage })
hi("@lsp.type.keyword",   { fg = c.lime_dim })
hi("@lsp.type.comment",   { fg = c.gray, italic = true })

-- Diagnostics
hi("DiagnosticError",          { fg = c.red })
hi("DiagnosticWarn",           { fg = c.lime_dim })
hi("DiagnosticInfo",           { fg = c.teal })
hi("DiagnosticHint",           { fg = c.gray_lt })
hi("DiagnosticUnderlineError", { sp = c.red, undercurl = true })
hi("DiagnosticUnderlineWarn",  { sp = c.lime_dim, undercurl = true })
hi("DiagnosticUnderlineInfo",  { sp = c.teal, undercurl = true })
hi("DiagnosticUnderlineHint",  { sp = c.gray_lt, undercurl = true })

-- Git signs
hi("GitSignsAdd",    { fg = c.lime })
hi("GitSignsChange", { fg = c.lime_dim })
hi("GitSignsDelete", { fg = c.red })

-- Telescope
hi("TelescopeBorder",        { fg = c.lime, bg = c.bg })
hi("TelescopePromptBorder",  { fg = c.lime, bg = c.bg })
hi("TelescopeResultsBorder", { fg = c.lime, bg = c.bg })
hi("TelescopePreviewBorder", { fg = c.lime, bg = c.bg })
hi("TelescopeTitle",         { fg = c.lime, bold = true })
hi("TelescopePromptTitle",   { fg = c.bg, bg = c.lime, bold = true })
hi("TelescopeResultsTitle",  { fg = c.lime })
hi("TelescopePreviewTitle",  { fg = c.lime })
hi("TelescopeSelection",     { bg = c.bg2 })
hi("TelescopeMatching",      { fg = c.lime_br, bold = true })

-- Neo-tree
hi("NeoTreeNormal",      { fg = c.fg, bg = c.bg })
hi("NeoTreeNormalNC",     { fg = c.fg, bg = c.bg })
hi("NeoTreeCursorLine",   { bg = c.bg1 })
hi("NeoTreeDirectoryIcon",{ fg = c.sage })
hi("NeoTreeDirectoryName",{ fg = c.sage })
hi("NeoTreeRootName",     { fg = c.lime, bold = true })
hi("NeoTreeGitAdded",     { fg = c.lime })
hi("NeoTreeGitModified",  { fg = c.lime_dim })
hi("NeoTreeGitDeleted",   { fg = c.red })

-- Indent and guides
hi("IndentBlanklineChar",        { fg = c.bg2 })
hi("IndentBlanklineContextChar", { fg = c.gray_dk })
