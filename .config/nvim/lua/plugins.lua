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

    -- status line
    use {
        'nvim-lualine/lualine.nvim',
        requires = {'kyazdani42/nvim-web-devicons', opt = true}
    }

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

    -- easymotion
    use {'phaazon/hop.nvim'}

    -- git
    use {
        'lewis6991/gitsigns.nvim',
        requires = {'nvim-lua/plenary.nvim'}
        -- tag = 'release' -- To use the latest release
    }
    use {'tpope/vim-fugitive'}
    use {'tpope/vim-rhubarb'}

    use {
        'tpope/vim-dispatch',
        setup = function() vim.g.dispatch_no_maps = 1 end
    }

    -- telescope
    use {
        'nvim-telescope/telescope.nvim',
        requires = {{'nvim-lua/plenary.nvim'}}
    }

    -- tmux
    use {
        'christoomey/vim-tmux-navigator',
        setup = function()
            -- vim.g.tmux_navigator_disable_when_zoomed = 1
            -- vim.g.tmux_navigator_preserve_zoom = 1
        end
    }

    -- color schemes
    use 'folke/tokyonight.nvim'
    -- use 'morhetz/gruvbox'
    use {"ellisonleao/gruvbox.nvim", requires = {"rktjmp/lush.nvim"}}

    -- treesitter
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
    use {'nvim-treesitter/playground'}
    use {'nvim-treesitter/nvim-treesitter-textobjects'}

    -- lsp & completion
    use 'neovim/nvim-lspconfig' -- collection of LSP configurations for neovim's LSP client
    use 'hrsh7th/cmp-nvim-lsp' -- LSP completion source for nvim-cmp
    use 'hrsh7th/cmp-nvim-lua' --
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/nvim-cmp'
    use 'mfussenegger/nvim-dap'
    use {'folke/trouble.nvim', requires = 'kyazdani42/nvim-web-devicons'}
    use 'tami5/lspsaga.nvim'

    -- rust
    use 'simrat39/rust-tools.nvim'
    use {
        'rust-lang/rust.vim',
        setup = function() vim.g.rustfmt_autosave = 1 end
    }

    -- snippets
    use 'L3MON4D3/LuaSnip'
    use 'saadparwaiz1/cmp_luasnip'

    -- sidebar explorer
    use {'kyazdani42/nvim-tree.lua', requires = 'kyazdani42/nvim-web-devicons'}

    -- zig
    use 'ziglang/zig.vim'

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
    use 'jbyuki/venn.nvim'
    use 'AndrewRadev/splitjoin.vim'
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
        'nanotee/zoxide.vim',
        config = function() vim.g.zoxide_prefix = 'j' end
    }
    use 'voldikss/vim-floaterm'
    use {
        'haya14busa/incsearch.vim',
        config = function()
            vim.g['incsearch#auto_nohlsearch'] = 1
            vim.cmd [[
              map /  <Plug>(incsearch-forward)
              map ?  <Plug>(incsearch-backward)
              map g/ <Plug>(incsearch-stay)
              map n  <Plug>(incsearch-nohl-n)
              map N  <Plug>(incsearch-nohl-N)
              map *  <Plug>(incsearch-nohl-*)
            ]]
        end
    }
end)
