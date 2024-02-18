return {
  "vimwiki/vimwiki",
  init = function()
    vim.g.vimwiki_list = {
      {
        path = '/home/navin/Documents/notes',
        syntax = 'markdown',
        ext = 'md',
        auto_tags = 1,
        auto_diary_index = 0,
        auto_generate_links = 0,
      }
    }
    vim.g.vimwiki_global_ext = 0
  end
}
