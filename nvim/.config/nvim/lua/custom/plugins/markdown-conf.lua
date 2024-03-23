return {
  'MeanderingProgrammer/markdown.nvim',
  ft = "markdown", -- or 'event = "VeryLazy"'
  name = 'render-markdown', -- Only needed if you have another plugin named markdown.nvim
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  config = function()
    require('render-markdown').setup({
      headings = { '󰖙', '󰈸', '▶', '✺', '', '⤷' },
      bullet = "",
      highlights = {
        heading = {
          -- Used for rendering heading line backgrounds
          backgrounds = { 'FloatShadow', '@comment.todo', '@comment.note', 'CurSearch' },
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
      },
    })
  end,
}
