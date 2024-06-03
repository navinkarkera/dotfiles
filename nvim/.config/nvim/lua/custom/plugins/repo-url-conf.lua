return {
  url = "https://git.sr.ht/~tomleb/repo-url.nvim",
  opts = {},
  keys = {
    {'<leader>rt', function() require('repo-url').copy_blob_url() end,   mode = { 'n', 'v' }, desc = 'Copy blob URL' },
    {'<leader>rT', function() require('repo-url').open_blob_url() end,   mode = { 'n', 'v' }, desc = 'Open blob URL' },
    {'<leader>rb', function() require('repo-url').copy_blame_url() end,  mode = { 'n', 'v' }, desc = 'Copy blame URL' },
    {'<leader>rB', function() require('repo-url').open_blame_url() end,  mode = { 'n', 'v' }, desc = 'Open blame URL' },
    {'<leader>rh', function() require('repo-url').copy_history_url() end,mode = { 'n', 'v' }, desc = 'Copy history URL' },
    {'<leader>rH', function() require('repo-url').open_history_url() end,mode = { 'n', 'v' }, desc = 'Open history URL' },
    {'<leader>rr', function() require('repo-url').copy_raw_url() end,    mode = { 'n', 'v' }, desc = 'Copy raw URL' },
    {'<leader>rR', function() require('repo-url').open_raw_url() end,    mode = { 'n', 'v' }, desc = 'Open raw URL'},
  },
}
