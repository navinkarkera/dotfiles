require'nvim-treesitter.configs'.setup {
  ensure_installed = { "python", "html", "javascript", "typescript", "rust", "bash", "json", "lua", "toml", "vue", "css" },     -- one of "all", "language", or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
    incremental_selection = { enable = true },
    indent = {
      enable = true
    },
    textobjects = {
        enable = true,
        keymaps = {
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
        }
    },
  },
}
