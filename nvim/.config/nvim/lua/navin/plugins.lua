local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  execute 'packadd packer.nvim'
end
-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Add your packages
return require('packer').startup(function()
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    use {
        'neovim/nvim-lspconfig',
        requires = {'glepnir/lspsaga.nvim'}
    }
    -- Plugins can have dependencies on other plugins
    use {
        'nvim-lua/completion-nvim',
        requires = {
            {'hrsh7th/vim-vsnip'},
            {'hrsh7th/vim-vsnip-integ'},
            {'rafamadriz/friendly-snippets'}
        }
    }
    use {
        'nvim-telescope/telescope.nvim',
        requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
    }
    use 'nvim-lua/lsp_extensions.nvim'

    use{'nvim-treesitter/nvim-treesitter', run=':TSUpdate'}


    use {'psf/black', branch='stable', ft={'python'}}
    use {'tpope/vim-fugitive', opt=true, cmd={'Git', 'G'}}
    use {'tpope/vim-markdown', ft={"markdown"}}
    use {'tpope/vim-commentary'}
    use {'tpope/vim-surround'}

    use {'mbbill/undotree', opt=true, cmd={'UndotreeToggle'}}
    use {'jiangmiao/auto-pairs'}

    use {'junegunn/goyo.vim', opt=true, cmd={'GoyoEnter'}}
    use {'junegunn/limelight.vim', opt=true, cmd={'Limelight'}}

    use {'vim-test/vim-test', opt=true, cmd={'TestNearest', 'TestFile', 'TestSuite', 'TestLast'}}


    use 'shaunsingh/nord.nvim'
    use {'folke/tokyonight.nvim', opt=true}
    use {'marko-cerovac/material.nvim', opt=true}

    use { 'hoob3rt/lualine.nvim' }
end)
