-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)

    -- Packer can manage itself
    use('wbthomason/packer.nvim')
    -- Slimmer Netrw
    use('tpope/vim-vinegar')

    -- File searching and grep-ing 
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.1',
        -- or                            , branch = '0.1.x',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    -- Color scheme
    use({ 'rose-pine/neovim', as = 'rose-pine' })

    use('nvim-vertsplit')

    -- Powerline like status bar
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }

    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
    use('nvim-treesitter/playground')
    -- simple common file navigator
    use('theprimeagen/harpoon')
    -- undo on roids
    use('mbbill/undotree')
    -- git management in a buffer
    use('tpope/vim-fugitive')
    -- easy motion style movements
    use {
        'phaazon/hop.nvim',
        branch = 'v2', -- optional but strongly recommended
        config = function()
      	  -- you can configure Hop the way you like here; see :h hop-config
      	  require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
        end
    }

    -- Tree style file explorer
    use {
        "nvim-neo-tree/neo-tree.nvim",
          branch = "v2.x",
          requires = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
          }
    }

    -- LSP and autocompletion
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        requires = {
      	  -- LSP Support
      	  {'neovim/nvim-lspconfig'},             -- Required
      	  {                                      -- Optional
      	  'williamboman/mason.nvim',
      	  run = function()
      		  pcall(vim.cmd, 'MasonUpdate')
      	  end,
        },
        {'williamboman/mason-lspconfig.nvim'}, -- Optional

        -- Autocompletion
        {'hrsh7th/nvim-cmp'},     -- Required
        {'hrsh7th/cmp-nvim-lsp'}, -- Required
        {'L3MON4D3/LuaSnip'},     -- Required
            }
    }

    -- AI Driven autocompletion
    use('github/copilot.vim')

end)
