return {
  'echasnovski/mini.nvim',
  version = false,
  config = function()
    require('mini.ai').setup()
    require('mini.pairs').setup()
    require('mini.bracketed').setup()
  end,
  lazy = false,
  keys = {
    { "<leader>tO", "<cmd>lua MiniFiles.open()<CR>", desc = "Open file browser" },
  },
}
