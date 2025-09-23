-- Configure nvim-window-picker with sensible defaults
-- Used by neo-tree 'w' mapping to pick a target window
local ok, picker = pcall(require, 'window-picker')
if not ok then return end

picker.setup({
  autoselect_one = true,
  include_current = false,
  filter_rules = {
    bo = {
      filetype = { 'neo-tree', 'neo-tree-popup', 'notify' },
      buftype = { 'terminal', 'quickfix' },
    },
  },
})

