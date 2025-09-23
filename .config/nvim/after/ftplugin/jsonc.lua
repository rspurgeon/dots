-- JSONC (JSON with comments) folding (Treesitter)
vim.opt_local.foldmethod = 'expr'
vim.opt_local.foldexpr = 'nvim_treesitter#foldexpr()'
-- Keep folds available but open by default
vim.opt_local.foldlevel = 99
vim.opt_local.foldenable = true

