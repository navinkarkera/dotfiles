local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
    execute 'packadd packer.nvim'
end

return require('packer').startup(function()
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    use {
        'neovim/nvim-lspconfig',
        config = function() require('lsp-config') end,
    }
    use {
        'hrsh7th/nvim-compe',
        requires = {
            {'hrsh7th/vim-vsnip'},
            {'hrsh7th/vim-vsnip-integ'},
            {'rafamadriz/friendly-snippets'}
        },
        config = function() require'compe-conf' end
    }
    use {
        'nvim-treesitter/nvim-treesitter',
        run=':TSUpdate',
        config = function() require "treesitter-config" end,
    }
    use {'nvim-treesitter/nvim-treesitter-textobjects'}

    use {'psf/black', opt=true, ft={'python'}}
    use {'tpope/vim-fugitive', opt=true, cmd={'Git', 'G'}}
    use 'b3nj5m1n/kommentary'
    use 'tpope/vim-surround'
    use {
        'windwp/nvim-autopairs',
        config = function() require 'nvim-autopairs'.setup() end,
    }
    use {
        'norcalli/nvim-colorizer.lua',
        config = function() require 'colorizer'.setup() end,
    }
    use 'jacoborus/tender.vim'
    use {'andymass/vim-matchup', event = 'VimEnter'}
    use {
        'kyazdani42/nvim-tree.lua',
        config = function() require 'tree' end,
    }
    use {
        'michaelb/sniprun',
        run='bash ./install.sh',
        opt=true,
        cmd={'SnipRun'}
    }
end)
