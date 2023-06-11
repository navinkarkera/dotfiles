vim.wo.spell = true
vim.wo.linebreak = true
vim.wo.conceallevel = 2
local function preview_md()
  local full_path = vim.fn.expand("%:p")
  if vim.fn.exists("$TMUX") == 1 then
    vim.cmd([[RunB tmux neww "glow -p ']] .. full_path .. [['"]])
  elseif vim.fn.exists("$WEZTERM_PANE") == 1 then
    vim.cmd([[RunB wezterm cli spawn -- zsh -ic "mdcat ']] .. full_path ..[[';read"]])
  end
end
vim.keymap.set("n", "<leader>mp", preview_md)
vim.keymap.set("n", "<leader>me", require 'mdeval'.eval_code_block)
