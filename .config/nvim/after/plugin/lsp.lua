local lsp_zero = require('lsp-zero')

-- nvim-cmp minimal mappings
local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
cmp.setup({
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  },
  sources = {
    { name = 'nvim_lsp' },
  },
  preselect = cmp.PreselectMode.None,
})

vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "❌",
      [vim.diagnostic.severity.WARN]  = "⚠️",
      [vim.diagnostic.severity.HINT]  = "💡",
      [vim.diagnostic.severity.INFO]  = "ℹ️",
    },
  },
})

lsp_zero.on_attach(function(_, bufnr)
  local opts = {buffer = bufnr, remap = false}

  -- TODO: Make better maps for insert mode
  vim.keymap.set("n", "<leader>ld", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "<leader>lt", function() vim.lsp.buf.type_definition() end, opts)
  vim.keymap.set("n", "<leader>lv", function() vim.lsp.buf.hover() end, opts)
  --vim.keymap.set("n", "<leader>Lw", function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set("n", "<leader>lo", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "<leader>ln", function() vim.diagnostic.jump({count=1}) end, opts)
  vim.keymap.set("n", "<leader>lp", function() vim.diagnostic.jump({count=-1}) end, opts)
  vim.keymap.set("n", "<leader>lc", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "<leader>lf", function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("n", "<leader>lr", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set("n", "<leader>lh", function() vim.lsp.buf.signature_help() end, opts)
  vim.keymap.set("n", "<leader>lD", function() vim.diagnostic.enable(false) end, opts)
  vim.keymap.set("n", "<leader>lE", function() vim.diagnostic.enable() end, opts)

end)

vim.keymap.set("n", "<leader>y", "\"+y")
vim.diagnostic.config({ virtual_text = true })

require('mason').setup({})
require('mason-lspconfig').setup({
  handlers = {
    function(server)
      if server == 'gopls' or server == 'golangci_lint_ls' then
        return
      end
      lsp_zero.default_setup(server)
    end
  },
})
