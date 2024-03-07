return {
  "zk-org/zk-nvim",
  config = function()
    require("zk").setup({
      picker = "fzf_lua",
      -- See Setup section below
    })
  end,
  keys = {
    { "<leader>zn", "<Cmd>ZkNew { title = vim.fn.input('Title: ') }<CR>", desc = "New note" },
    { "<leader>zo", "<Cmd>ZkNotes { sort = { 'modified' } }<CR>", desc = "Open notes" },
    { "<leader>zt", "<Cmd>ZkTags<CR>", desc = "Select notes with tag" },
    { "<leader>zf", "<Cmd>ZkNotes { sort = { 'modified' }, match = { vim.fn.input('Search: ') } }<CR>", desc = "Search notes for given query" },
    { "<leader>zf", ":'<,'>ZkMatch<CR>", desc = "Search notes for given query", mode = "v" },
    { "<leader>znc", ":'<,'>ZkNewFromContentSelection { title = vim.fn.input('Title: ') }<CR>", mode = "v" }
  }
}
