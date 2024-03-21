return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-lua/plenary.nvim",
  },
  config = function()
    require("codecompanion").setup({
      adapters = {
        chat = require("codecompanion.adapters").use("ollama", {
          schema = {
            model = {
              default = "mistral"
            }
          }
        }),
        inline = require("codecompanion.adapters").use("ollama", {
          schema = {
            model = {
              default = "mistral"
            }
          }
        }),
      },
    })
  end
}
