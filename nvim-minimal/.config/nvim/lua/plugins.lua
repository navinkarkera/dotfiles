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
    use { 'hrsh7th/cmp-nvim-lsp' }

    -- lsp plugings
    use {
        'neovim/nvim-lspconfig',
        opt = true,
        event = 'VimEnter',
        config = function() require('lsp-config') end,
    }
    use {
        'L3MON4D3/LuaSnip',
        opt = true,
        after = 'nvim-lspconfig',
    }
    use {
        'hrsh7th/nvim-cmp',
        config = function() require'cmp-conf' end,
        opt = true,
        after = 'LuaSnip',
    }

    -- cmp sources
    use {
        'saadparwaiz1/cmp_luasnip',
        opt = true,
        after = 'nvim-cmp',
    }
    use {
        'hrsh7th/cmp-buffer',
        opt = true,
        after = 'nvim-cmp',
    }
    use {
        'hrsh7th/cmp-path',
        opt = true,
        after = 'nvim-cmp',
    }
    use {
        'hrsh7th/cmp-nvim-lua',
        opt = true,
        ft = {"lua", "vim"},
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
    use {
        'windwp/nvim-autopairs',
        config = function()
            require('nvim-autopairs').setup({
                disable_filetype = { "TelescopePrompt" , "vim" },
            })
        end,
        event = 'InsertEnter',
    }
    use {
        'norcalli/nvim-colorizer.lua',
        config = function() require 'colorizer'.setup() end,
        event = 'VimEnter',
    }
    use {
        'projekt0n/github-nvim-theme',
        event = 'VimEnter',
        config = function()
            require('github-theme').setup({
                transparent = true,
                hideInactiveStatusline = true,
                darkSidebar = true,
            })
        end,
    }
    use {'andymass/vim-matchup', event = 'BufEnter'}
    use {
        'kyazdani42/nvim-tree.lua',
        config = function() require 'tree' end,
        cmd = {
			'NvimTreeClipboard',
			'NvimTreeClose',
			'NvimTreeFindFile',
			'NvimTreeOpen',
			'NvimTreeRefresh',
			'NvimTreeToggle',
		},
    }
    use {
        'hoob3rt/lualine.nvim',
        event = 'VimEnter',
        config = function()
            require('lualine').setup({
                options = {
                    icons_enabled = false,
                    theme = 'github',
                    component_separators = {'', ''},
                    section_separators = {'', ''},
                    disabled_filetypes = {}
                },
            })
        end,
    }
    use {
        "akinsho/nvim-toggleterm.lua",
        event = 'VimEnter',
        config = function()
            require("terminal-conf")
        end
    }
end)
