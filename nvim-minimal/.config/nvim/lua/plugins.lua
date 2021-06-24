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
    use 'neovim/nvim-lspconfig'
    use {
        'nvim-lua/completion-nvim',
        requires = {
            {'hrsh7th/vim-vsnip'},
            {'hrsh7th/vim-vsnip-integ'},
            {'rafamadriz/friendly-snippets'}
        }
    }
    use{'nvim-treesitter/nvim-treesitter', run=':TSUpdate'}

    use {'psf/black', ft={'python'}}
    use {'tpope/vim-fugitive', opt=true, cmd={'Git', 'G'}}
    use 'b3nj5m1n/kommentary'
    use 'tpope/vim-surround'
    use {'windwp/nvim-autopairs', config={require('nvim-autopairs').setup()}}
    use 'norcalli/nvim-colorizer.lua'
    use 'jacoborus/tender.vim'
end)
