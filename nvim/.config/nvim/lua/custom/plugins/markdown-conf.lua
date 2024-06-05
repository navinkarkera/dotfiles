return {
  'MeanderingProgrammer/markdown.nvim',
  ft = "markdown", -- or 'event = "VeryLazy"'
  name = 'render-markdown', -- Only needed if you have another plugin named markdown.nvim
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  config = function()
    require('render-markdown').setup({
      headings = { '󰖙 ', '󰈸 ', '▶ ', '✺ ', ' ', '⤷ ' },
      quote = '┃',
      bullets = {"●","○","◆","◇"},
      win_options = {
          -- See :h 'conceallevel'
          conceallevel = {
              -- Used when not being rendered, get user setting
              default = vim.api.nvim_get_option_value('conceallevel', {}),
              -- Used when being rendered, concealed text is completely hidden
              rendered = 2,
          },
          -- See :h 'concealcursor'
          concealcursor = {
              -- Used when not being rendered, get user setting
              default = vim.api.nvim_get_option_value('concealcursor', {}),
              -- Used when being rendered, conceal text in all modes
              rendered = '',
          },
      },
      highlights = {
        heading = {
          -- Used for rendering heading line backgrounds
          backgrounds = { 'CurSearch', '@comment.todo', '@comment.note', 'FloatTitle' },
          -- Used for rendering the foreground of the heading character only
          foregrounds = {
            'markdownH1',
            'markdownH2',
            'markdownH3',
            'markdownH4',
            'markdownH5',
            'markdownH6',
          },
        },
        -- Used when displaying code blocks
        code = 'NormalFloat',
        -- Used when displaying bullet points in list
        bullet = 'Normal',
        table = {
          -- Used when displaying header in a markdown table
          head = '@markup.heading',
          -- Used when displaying non header rows in a markdown table
          row = 'Normal',
        },
        latex = 'Special',
        -- Quote character in a block quote
        quote = '@markup.quote',
      },
    })
  end,
}
