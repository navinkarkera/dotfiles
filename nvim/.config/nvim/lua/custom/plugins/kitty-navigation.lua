return {
  "MunsMan/kitty-navigator.nvim",
  keys = {
    {"<m-h>", function()require("kitty-navigator").navigateLeft()end, desc = "Move left a Split", mode = {"n", "t"}},
    {"<m-j>", function()require("kitty-navigator").navigateDown()end, desc = "Move down a Split", mode = {"n", "t"}},
    {"<m-k>", function()require("kitty-navigator").navigateUp()end, desc = "Move up a Split", mode = {"n", "t"}},
    {"<m-l>", function()require("kitty-navigator").navigateRight()end, desc = "Move right a Split", mode = {"n", "t"}},
  },
  build = {
    "cp navigate_kitty.py ~/.config/kitty",
    "cp pass_keys.py ~/.config/kitty",
  },
}
