-- Allow overriding build tags via env var so projects
-- with custom tags (e.g., e2e) work in gopls.
local gopls_build_tags = os.getenv('GOPLS_BUILD_TAGS') or 'integration,e2e'

require('go').setup({
  -- Let go.nvim start ONE gopls and ONE golangci-lint LS
  lsp_cfg = {                  -- table = customise gopls here
    settings = {
      gopls = {
        buildFlags = { string.format('-tags=%s', gopls_build_tags) },
      },
    },
  },

  -- Make sure the linter field is *disabled* if you don't want it,
  -- or leave it = 'golangci-lint' if you DO want it (once).
  linter = "",                 -- <- empty string disables LS entirely

  -- inlay-hints table is required by new go.nvim API
  inlay_hints = { enable = false },
})

-- Run gofmt on save

local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
   require('go.format').gofmt()
  end,
  group = format_sync_grp,
})

-- Golang Debug Adapter, uses delve (dlv)
require('dap-go').setup()

vim.api.nvim_create_user_command('GoFumpt', '!gofumpt -w %', {})
