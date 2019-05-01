-- packer bootstrapping
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({
        'git', 'clone', '--depth', '1',
        'https://github.com/wbthomason/packer.nvim', install_path
    })
end

-- reload
vim.cmd([[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins.lua source <afile> | PackerCompile
    augroup end
]])

-- pluggins 
return require('packer').startup(function()
    -- plugin management
    use 'wbthomason/packer.nvim'

    -- lua conf
    use 'nvim-lua/plenary.nvim'
    use 'nvim-lua/popup.nvim'

    -- comments
    use 'terrortylor/nvim-comment'

    -- surroundings
    use {
        'machakann/vim-sandwich',
        setup = function() 
            vim.g.sandwich_no_default_key_mappings = 1
            vim.g.operator_sandwich_no_default_key_mappings = 1
        end
    }

    -- telescope
    use {
        'nvim-telescope/telescope.nvim',
        requires = {{'nvim-lua/plenary.nvim'}}
    }

    -- tmux
    use 'christoomey/vim-tmux-navigator'

    -- color schemes
    use 'folke/tokyonight.nvim'
    use 'morhetz/gruvbox'

    -- treesitter
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}

    -- completion
    use 'neovim/nvim-lspconfig' -- collection of LSP configurations for neovim's LSP client
    use 'hrsh7th/cmp-nvim-lsp' -- LSP completion source for nvim-cmp
    use 'hrsh7th/cmp-nvim-lua' -- 
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/nvim-cmp'

    -- rust
    use 'simrat39/rust-tools.nvim'
    use 'rust-lang/rust.vim'

    -- snippets
    use 'hrsh7th/cmp-vsnip'

    -- sidebar explorer
    use {
        'kyazdani42/nvim-tree.lua',
        requires = 'kyazdani42/nvim-web-devicons',
        config = function() require'nvim-tree'.setup {} end
    }

    -- satan
    use 'github/copilot.vim'
end)
