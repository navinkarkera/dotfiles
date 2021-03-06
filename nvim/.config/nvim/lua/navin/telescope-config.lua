local actions = require('telescope.actions')
require('telescope').setup{
    defaults = {
        vimgrep_arguments = {
            'rg',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case'
        },
        mappings = {
            i = {
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
                ["<C-q>"] = actions.send_to_qflist
            }
        },
        prompt_position = "bottom",
        prompt_prefix = " ",
        selection_caret = " ",
        entry_prefix = "  ",
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "descending",
        layout_strategy = "horizontal",
        layout_defaults = {
            horizontal = {
                mirror = false,
            },
            vertical = {
                mirror = false,
            },
        },
        file_sorter =  require'telescope.sorters'.get_fuzzy_file,
        file_ignore_patterns = {},
        generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
        shorten_path = true,
        winblend = 0,
        width = 0.75,
        preview_cutoff = 120,
        results_height = 1,
        results_width = 0.8,
        border = {},
        borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
        color_devicons = true,
        use_less = true,
        set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
        file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
        grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
        qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,
    }
}


vim.api.nvim_set_keymap("n", "<C-p>", [[<Cmd>lua require('telescope.builtin').git_files()<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<leader>pf", [[<Cmd>lua require('telescope.builtin').find_files()<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<leader>tf", [[<Cmd>lua require('telescope.builtin').file_browser()<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<leader>ps", [[<Cmd>lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<leader>pw", [[<Cmd>lua require('telescope.builtin').grep_string()<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<C-n>", [[<Cmd>lua require('telescope.builtin').buffers()<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<leader>gr", [[<Cmd>lua require('telescope.builtin').lsp_references()<CR>]], {noremap = true, silent = true})
