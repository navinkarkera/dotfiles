return {
  'Wansmer/treesj',
  dependencies = { 'nvim-treesitter/nvim-treesitter' }, -- if you install parsers with `nvim-treesitter`
  config = function()
    require('treesj').setup({
      use_default_keymaps = false,
      max_join_length = 500,
    })
  end,
  keys = {
    { "gS", "<cmd>TSJToggle<CR>", desc = "Split or join" },
  },
}
