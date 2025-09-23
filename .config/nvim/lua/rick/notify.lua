-- Filter or downgrade specific noisy notifications
local orig_notify = vim.notify

vim.notify = function(msg, level, opts)
  if type(msg) == 'string' then
    -- Suppress nvim-lspconfig deprecation notice about require('lspconfig') framework
    if msg:match("require%(%s*'lspconfig'%s*%)") and msg:lower():find('deprecated', 1, true) then
      return
    end
  end
  return orig_notify(msg, level, opts)
end
