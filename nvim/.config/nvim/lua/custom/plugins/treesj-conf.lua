return {
  'Wansmer/treesj',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  config = function()
    require('treesj').setup({
      use_default_keymaps = false,
    })
  end,
  keys = {
    { "gS", "<cmd>TSJToggle<CR>", desc = "Split or join" },
  },
}
