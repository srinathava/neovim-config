local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    }
    print "Installing packer close and reopen Neovim..."
    vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
augroup packer_user_config
autocmd!
autocmd BufWritePost plugins.lua source <afile> | PackerSync
augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Have packer use a popup window
packer.init {
    display = {
        open_fn = function()
            return require("packer.util").float { border = "rounded" }
        end,
    },
}

-- Install your plugins here
return packer.startup(function(use)
    -- My plugins here
    use "lewis6991/impatient.nvim"
    use "wbthomason/packer.nvim" -- Have packer manage itself
    use "nvim-lua/plenary.nvim" -- Useful lua functions used by lots of plugins

    -- Colorschemes
    use 'folke/tokyonight.nvim'

    -- cmp plugins
    use "hrsh7th/nvim-cmp" -- The completion plugin
    use "hrsh7th/cmp-buffer" -- buffer completions
    use "saadparwaiz1/cmp_luasnip" -- snippet completions
    use "hrsh7th/cmp-nvim-lsp"
    use 'hrsh7th/cmp-nvim-lsp-signature-help'

    -- snippets
    use "L3MON4D3/LuaSnip" --snippet engine
    use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

    -- LSP
    use "neovim/nvim-lspconfig" -- enable LSP
    use "williamboman/nvim-lsp-installer" -- simple to use language server installer
    use "jose-elias-alvarez/null-ls.nvim"

    -- Telescope
    use "nvim-telescope/telescope.nvim"

    -- Treesitter
    use {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
    }

    use {
        "JoosepAlviste/nvim-ts-context-commentstring",
        config = function()
            require 'nvim-treesitter.configs'.setup {
                context_commentstring = {
                    enable = true,
                    config = {
                        cpp = { __default = '// %s', __multiline = '/* %s */' }
                    }

                }
            }
        end
    }

    use 'tpope/vim-commentary'

    -- Git
    use 'tpope/vim-fugitive'
    use {
        "lewis6991/gitsigns.nvim",
        config = function()
            require('gitsigns').setup()
        end
    }

    use {
        "akinsho/toggleterm.nvim",
        config = function()
            require("toggleterm").setup()
        end
    }

    use 'folke/which-key.nvim'

    use 'dstein64/vim-startuptime'

    -- Auto-detect sw/expandtab based on current file
    use 'tpope/vim-sleuth'

    use 'mustache/vim-mustache-handlebars'

    use {
        'epwalsh/obsidian.nvim',
        config = function()
            require("obsidian").setup({
                dir = '/mathworks/devel/sandbox/savadhan/obsidian/work_stuff',
                completion = {
                    nvim_cmp = true
                }
            })
        end
    }

    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true },
        config = function()
            require('lualine').setup()
        end
    }

    use {
        'nvim-treesitter/nvim-treesitter-context',
        config = function()
            require('treesitter-context').setup{
                max_lines = 0,
                trim_scope = 'inner'
            }
        end
    }

    use "folke/neodev.nvim"

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)

