local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
  'tsserver',
  'rust_analyzer',
  -- Add GoLang
  -- Add Lua
})

-- Fix Undefined global 'vim'
lsp.nvim_workspace()

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
  ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
  ['<C-y>'] = cmp.mapping.confirm( { select = true } ),
  ['<C-e>'] = cmp.mapping.abort(),
  ['<C-Space>'] = cmp.mapping.complete(),
  ['<CR>'] = cmp.mapping.confirm({ select = true }),
})

cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil

lsp.setup_nvim_cmp({
  mapping = cmp_mappings
})

vim.fn.sign_define("DiagnosticSignError", { text = "❌", texthl = "LspDiagnosticsSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "⚠️", texthl = "LspDiagnosticsSignError" })
vim.fn.sign_define("DiagnosticSignHint", { text = "💡", texthl = "LspDiagnosticsSignError" })
vim.fn.sign_define("DiagnosticSignInfo", { text = "ℹ️", texthl = "LspDiagnosticsSignError" })

lsp.on_attach(function(_, bufnr)
  local opts = {buffer = bufnr, remap = false}

  -- TODO: Make better maps for insert mode
  vim.keymap.set("n", "<leader>ld", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "<leader>lt", function() vim.lsp.buf.type_definition() end, opts)
  vim.keymap.set("n", "<leader>lv", function() vim.lsp.buf.hover() end, opts)
  --vim.keymap.set("n", "<leader>Lw", function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set("n", "<leader>lo", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "<leader>ln", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "<leader>lp", function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set("n", "<leader>lc", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "<leader>lf", function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("n", "<leader>lr", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set("n", "<leader>lh", function() vim.lsp.buf.signature_help() end, opts)
  vim.keymap.set("n", "<leader>lD", function() vim.diagnostic.enable(false) end, opts)
  vim.keymap.set("n", "<leader>lE", function() vim.diagnostic.enable() end, opts)

end)

vim.keymap.set("n", "<leader>y", "\"+y")

lsp.setup()

vim.diagnostic.config({
    virtual_text = true
})

