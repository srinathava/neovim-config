return {
    -- My plugins here
    "nvim-lua/plenary.nvim", -- Useful lua functions used by lots of plugins

    -- Colorschemes
    { 'folke/tokyonight.nvim', lazy = true},

    { "catppuccin/nvim", name = "catppuccin", priority = 1000 },

    -- LSP
    {
        "neovim/nvim-lspconfig", -- enable LSP
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            "jose-elias-alvarez/null-ls.nvim",
            "williamboman/mason.nvim",
            { "folke/neodev.nvim", opts = {} }
        },
        config = function()
            require("user.lsp")
        end
    },

    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate", -- :MasonUpdate updates registry contents
        cmd = "Mason"
    },

    -- cmp plugins
    {
        "hrsh7th/nvim-cmp", -- The completion plugin
        dependencies = {
            "hrsh7th/cmp-buffer", -- buffer completions
            "saadparwaiz1/cmp_luasnip", -- snippet completions
            "hrsh7th/cmp-nvim-lsp",
            'hrsh7th/cmp-nvim-lsp-signature-help',

            -- snippets
            "L3MON4D3/LuaSnip", --snippet engine
            "rafamadriz/friendly-snippets", -- a bunch of snippets to use
        },
        event = "InsertEnter",
        config = function()
            require('user.cmp')
        end
    },

    {
        "akinsho/toggleterm.nvim",
        cmd = "ToggleTerm",
        config = function()
            require("toggleterm").setup()
        end
    },

    {
        'folke/which-key.nvim',
        config = function()
            require('user.whichkey').setup()
        end
    },

    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        cmd = "Neotree",
        dependencies = {
          "nvim-lua/plenary.nvim",
          "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
          "MunifTanjim/nui.nvim",
        }
    }
}

