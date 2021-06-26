require'nvim-treesitter.configs'.setup {
  ensure_installed = {
      "python",
      "html",
      "javascript",
      "typescript",
      "rust",
      "bash",
      "json",
      "lua",
      "toml",
      "vue",
      "css",
  }, -- one of "all", "language", or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
    indent = {
      enable = true
    },
    autotag = {
      enable = true
    },
  },
}
