local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
  'tsserver',
  'rust_analyzer',
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

lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = 'E',
        warn  = 'W',
        hint  = 'H',
        info  = 'I'
    }
})

lsp.on_attach(function(_, bufnr)
  local opts = {buffer = bufnr, remap = false}

  -- TODO: Make better maps for insert mode
  vim.keymap.set("n", "<leader>Ld", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "<leader>Lt", function() vim.lsp.buf.type_definition() end, opts)
  vim.keymap.set("n", "<leader>Lv", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "<leader>Lw", function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set("n", "<leader>Lo", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "<leader>Ln", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "<leader>Lp", function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set("n", "<leader>Lc", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "<leader>Lf", function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("n", "<leader>Lr", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set("n", "<leader>Lh", function() vim.lsp.buf.signature_help() end, opts)
  vim.keymap.set("n", "<leader>LD", function() vim.diagnostic.disable() end, opts)
  vim.keymap.set("n", "<leader>LE", function() vim.diagnostic.enable() end, opts)

end)

vim.keymap.set("n", "<leader>y", "\"+y")

lsp.setup()

vim.diagnostic.config({
    virtual_text = true
})

