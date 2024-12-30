return {
  "stevearc/oil.nvim",
  opts = {
    float = {
      -- Padding around the floating window
      padding = 2,
      max_width = 250,
      max_height = 60,
      border = "rounded",
      win_options = {
        winblend = 0,
      },
      -- optionally override the oil buffers window title with custom function: fun(winid: integer): string
      get_win_title = nil,
      -- preview_split: Split direction: "auto", "left", "right", "above", "below".
      preview_split = "auto",
    },
    win_options = {
      wrap = false,
      signcolumn = "no",
      cursorcolumn = false,
      foldcolumn = "0",
      spell = false,
      list = false,
      conceallevel = 3,
      concealcursor = "nvic",
      number = false,
      relativenumber = false,
    },
  },
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    { "<leader>to", "<cmd>lua require('oil').toggle_float()<CR>", desc = "Open parent directory" },
  }
}
