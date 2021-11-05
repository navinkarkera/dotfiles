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

    -- lsp plugings
    use {
        'L3MON4D3/LuaSnip',
    }
    use {
        "hrsh7th/nvim-cmp",
        config = function() require('cmp-conf') end,
        requires = {
            {"saadparwaiz1/cmp_luasnip"},
        }
    }
    use {
        'neovim/nvim-lspconfig',
        config = function() require('lsp-config') end,
        requires = {
            {"hrsh7th/cmp-nvim-lsp"},
        }
    }
    use {'psf/black', opt=true, cmd={'Black'}}

    use {
        'nvim-treesitter/nvim-treesitter',
        run=':TSUpdate',
        config = function() require "treesitter-config" end,
    }
    use {
        'nvim-treesitter/nvim-treesitter-textobjects',
        after = 'nvim-treesitter'
    }

    use {'tpope/vim-fugitive', opt=true, cmd={'Git', 'G'}}
    use {'b3nj5m1n/kommentary', event = 'BufEnter'}
    use {'tpope/vim-surround', event = 'BufEnter'}
    use {'andymass/vim-matchup', event = 'BufEnter'}
    use {'mattn/emmet-vim', ft={
        "html",
        "javascript",
        "vue",
        "javascriptreact",
        "jsx",
        "xml",
        "htmldjango"
    }}
    use {'AndrewRadev/switch.vim', event = 'BufEnter'}
    use {'AndrewRadev/splitjoin.vim', event = 'BufEnter'}
    use {
        "preservim/vimux",
        event = 'VimEnter',
        config = function()
            require("vimux-conf")
        end
    }
    use {
        "numToStr/Navigator.nvim",
        event = 'VimEnter',
        config = function()
            require("nav-conf")
        end,
    }
    use {
        "lambdalisue/fern-hijack.vim",
        requires = {
            {"lambdalisue/fern.vim"},
        }
    }
    use {
        'mfussenegger/nvim-fzy',
        event = 'VimEnter',
        config = function()
            require("fzy-conf")
        end,
    }
    use {
        'kevinhwang91/nvim-bqf',
        ft = 'qf',
        config = function()
            require("bqf-conf")
        end,
    }
end)
