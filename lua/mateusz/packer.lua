-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use {
        'nvim-telescope/telescope.nvim',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    use 'folke/tokyonight.nvim'

    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use 'nvim-treesitter/playground'
    use 'theprimeagen/harpoon'
    use 'mbbill/undotree'
    use 'tpope/vim-fugitive'

    use { "akinsho/toggleterm.nvim", tag = '*', config = function()
        require("toggleterm").setup()
    end }

    -- Debugging
    use 'mfussenegger/nvim-dap'
    use {
        "rcarriga/nvim-dap-ui",
        requires = {
            { "mfussenegger/nvim-dap" },
            { "nvim-neotest/nvim-nio" }
        }
    }
    use 'mfussenegger/nvim-dap-python'

    -- LSP (native vim.lsp.config, no lsp-zero)
    use 'neovim/nvim-lspconfig'
    use 'mason-org/mason.nvim'
    use 'mason-org/mason-lspconfig.nvim'

    -- Autocompletion
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-nvim-lua'
    use 'saadparwaiz1/cmp_luasnip'

    -- Snippets
    use 'L3MON4D3/LuaSnip'
    use 'rafamadriz/friendly-snippets'

    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons', -- optional
        },
    }

    use 'mfussenegger/nvim-jdtls'
end)
