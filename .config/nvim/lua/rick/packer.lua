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
    -- better escape
    -- can use jj or jk to escape insert mode 
    use {
      "max397574/better-escape.nvim",
      config = function()
        require("better_escape").setup()
      end,
    }

    -- Color scheme
    use({ 'rose-pine/neovim', as = 'rose-pine' })

    -- navigate between tmux panes and vim splits
    use('christoomey/vim-tmux-navigator')

    -- Powerline like status bar
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }

    use('lewis6991/gitsigns.nvim')
    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
    use('nvim-treesitter/playground')

    -- simple common file navigator
    use('theprimeagen/harpoon')
    -- undo on roids
    use('mbbill/undotree')
    -- git management in a buffer
    use('tpope/vim-fugitive')
    -- adding, changing, or deleting surrounding parentheses, brackets, quotes, XML tags, and more
    use({
        "kylechui/nvim-surround",
        tag = "*", -- Use for stability; omit to use `main` branch for the latest features
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    })
    -- used for splitting/joining blocks of code like arrays, hashes, statements, objects, dictionaries, etc
    use({
        'Wansmer/treesj',
        requires = { 'nvim-treesitter' },
        config = function()
            require('treesj').setup({
                --[[ your config ]]
            })
        end,
    })

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
      	  {'neovim/nvim-lspconfig'},
      	  {'williamboman/mason.nvim', run = ":MasonUpdate"},
          {'williamboman/mason-lspconfig.nvim'},

          -- Autocompletion
          {'hrsh7th/nvim-cmp'},
          {'hrsh7th/cmp-nvim-lsp'},
          {'L3MON4D3/LuaSnip'},
        }
    }

    -- AI Driven autocompletion
    use('github/copilot.vim')
end)
