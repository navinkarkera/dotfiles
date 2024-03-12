return {
  'echasnovski/mini.nvim',
  version = false,
  config = function()
    require('mini.ai').setup()
    require('mini.comment').setup()
    require('mini.files').setup()
    require('mini.pairs').setup()
  end,
  lazy = false,
  keys = {
    { "<leader>to", "<cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<CR>", desc = "Open file browser" },
    { "<leader>tO", "<cmd>lua MiniFiles.open()<CR>", desc = "Open file browser" },
  },
}
