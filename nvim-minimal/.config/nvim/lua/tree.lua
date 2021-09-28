local g = vim.g
-- default will show icon by default if no icon is provided
-- default shows no icon by default
g.nvim_tree_show_icons = {
	git = 0,
  folders = 0, -- or 0,
  files = 0, -- or 0,
  folder_arrows = 0, -- or 0
}
g.nvim_tree_gitignore = 0
g.nvim_tree_git_hl = 0

require'nvim-tree'.setup {
    auto_close = true,
    update_focused_file = {
        enable = true,
    }
}
