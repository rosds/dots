-- packer bootstrapping
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

-- reload after safe
local packer = vim.api.nvim_create_augroup("packer_user_config", {})
vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = "plugins.lua",
    command = "source <afile> | PackerCompile",
    group = packer,
    desc = "reload packer after modifications"
})

return require('packer').startup(function(use)
    -- plugin management
    use 'wbthomason/packer.nvim'

    -- lua
    use 'nvim-lua/plenary.nvim'

    -- surroundings
    use {
        'machakann/vim-sandwich',
        setup = function()
            vim.g.sandwich_no_default_key_mappings = 1
            vim.g.operator_sandwich_no_default_key_mappings = 1
        end
    }

    -- comments
    use {
        'terrortylor/nvim-comment',
        config = function()
            require 'nvim_comment'.setup({
                line_mapping = '<leader>cl',
                operator_mapping = '<leader>c',
            })
        end,
    }

    -- explorer
    use {
        'kyazdani42/nvim-tree.lua',
        requires = 'kyazdani42/nvim-web-devicons'
    }

    -- easymotion
    use 'phaazon/hop.nvim'

    -- telescope
    use {
        'nvim-telescope/telescope.nvim',
        requires = 'nvim-lua/plenary.nvim'
    }

    -- lsp & completion
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-nvim-lua'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/nvim-cmp'

    -- snippets
    use 'L3MON4D3/LuaSnip'
    use 'saadparwaiz1/cmp_luasnip'

    -- treesitter
    use 'nvim-treesitter/nvim-treesitter'
    use 'nvim-treesitter/playground'
    use 'nvim-treesitter/nvim-treesitter-textobjects'

    -- color
    use 'ellisonleao/gruvbox.nvim'

    -- git
    use 'lewis6991/gitsigns.nvim'
    use 'tpope/vim-fugitive'
    use 'tpope/vim-rhubarb'
    use 'tpope/vim-unimpaired'
    use {'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim'}

    -- tmux
    use {
        'christoomey/vim-tmux-navigator',
        setup = function()
            vim.g.tmux_navigator_disable_when_zoomed = 1
            -- vim.g.tmux_navigator_preserve_zoom = 1
        end
    }

    -- rust
    use 'simrat39/rust-tools.nvim'
    use {
        'rust-lang/rust.vim',
        setup = function() vim.g.rustfmt_autosave = 1 end
    }

    -- 666
    use {
        'github/copilot.vim',
        setup = function()
            vim.g.copilot_no_tab_map = true
            vim.g.copilot_assume_mapped = true
            vim.g.copilot_tab_fallback = ""
        end
    }

    -- misc
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true },
        config = function() require 'lualine'.setup() end
    }
    use {
        'inkarkat/vim-mark',
        requires = 'inkarkat/vim-ingo-library',
        setup = function() vim.g.mw_no_mappings = 1 end
    }
    use {
        'windwp/nvim-autopairs',
        config = function() require'nvim-autopairs'.setup {} end
    }
    use {
        'tpope/vim-dispatch',
        setup = function() vim.g.dispatch_no_maps = 1 end
    }
    use 'jbyuki/venn.nvim'
    use 'AndrewRadev/splitjoin.vim'
    use 'dhruvasagar/vim-table-mode'
    use {
        'vimwiki/vimwiki',
        setup = function()
            vim.g.vimwiki_list = {
                {path = '~/vimwiki/', syntax = 'markdown', ext = 'md'}
            }
        end
    }

    if packer_bootstrap then
        require('packer').sync()
    end
end)
