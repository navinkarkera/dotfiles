require("toggleterm").setup{
  -- size can be a number or function which is passed the current terminal
  size = 15,
  open_mapping = [[<M-t>]],
  hide_numbers = true, -- hide the number column in toggleterm buffers
  shade_terminals = true,
  start_in_insert = true,
  insert_mappings = true, -- whether or not the open mapping applies in insert mode
  persist_size = true,
  close_on_exit = true, -- close the terminal window when the process exits
  shell = vim.o.shell, -- change the default shell
}
