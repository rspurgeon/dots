-- Helper command to install common Go developer tools
-- Usage:
--   :GoToolsInstall        -> install a curated default set
--   :GoToolsInstall!       -> install extended set (more generators/helpers)

local function has(cmd)
  return vim.fn.executable(cmd) == 1
end

local default_tools = {
  { name = 'goimports',     pkg = 'golang.org/x/tools/cmd/goimports@latest' },
  { name = 'gofumpt',       pkg = 'mvdan.io/gofumpt@latest' },
  { name = 'gotests',       pkg = 'github.com/cweill/gotests/gotests@latest' },
  { name = 'gomodifytags',  pkg = 'github.com/fatih/gomodifytags@latest' },
  { name = 'iferr',         pkg = 'github.com/koron/iferr@latest' },
  { name = 'impl',          pkg = 'github.com/josharian/impl@latest' },
  { name = 'mockgen',       pkg = 'github.com/golang/mock/mockgen@latest' },
  { name = 'govulncheck',   pkg = 'golang.org/x/vuln/cmd/govulncheck@latest' },
  { name = 'callgraph',     pkg = 'golang.org/x/tools/cmd/callgraph@latest' },
}

local extended_tools = {
  { name = 'gotestsum',     pkg = 'gotest.tools/gotestsum@latest' },
  { name = 'richgo',        pkg = 'github.com/kyoh86/richgo@latest' },
  { name = 'go-enum',       pkg = 'github.com/abice/go-enum@latest' },
  { name = 'fillswitch',    pkg = 'github.com/davidrjenni/reftools/cmd/fillswitch@latest' },
  { name = 'gonew',         pkg = 'golang.org/x/tools/cmd/gonew@latest' },
}

local function install_tools(tools)
  if not has('go') then
    vim.notify('Go not found in PATH; cannot install tools.', vim.log.levels.ERROR)
    return
  end

  local idx = 0
  local total = #tools

  local function install_next()
    idx = idx + 1
    if idx > total then
      vim.notify('Go tools install complete ✔︎', vim.log.levels.INFO)
      return
    end

    local t = tools[idx]
    vim.notify(string.format('[%d/%d] Installing %s...', idx, total, t.name), vim.log.levels.INFO)

    vim.system({ 'go', 'install', t.pkg }, { text = true }, function(obj)
      if obj.code == 0 then
        vim.schedule(function()
          vim.notify(string.format('Installed %s', t.name), vim.log.levels.INFO)
          install_next()
        end)
      else
        vim.schedule(function()
          vim.notify(string.format('Failed %s: %s', t.name, obj.stderr or 'error'), vim.log.levels.ERROR)
          install_next()
        end)
      end
    end)
  end

  install_next()
end

vim.api.nvim_create_user_command('GoToolsInstall', function(opts)
  local list = {}
  for _, t in ipairs(default_tools) do table.insert(list, t) end
  if opts.bang then
    for _, t in ipairs(extended_tools) do table.insert(list, t) end
  end
  install_tools(list)
end, { bang = true, desc = 'Install common Go tools (@latest). Use ! for extended set.' })

