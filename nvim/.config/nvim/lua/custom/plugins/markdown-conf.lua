return {
  'MeanderingProgrammer/markdown.nvim',
  ft = "markdown", -- or 'event = "VeryLazy"'
  name = 'render-markdown', -- Only needed if you have another plugin named markdown.nvim
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  config = function()
    require('render-markdown').setup({
        markdown_query = [[
            (atx_heading [
                (atx_h1_marker)
                (atx_h2_marker)
                (atx_h3_marker)
                (atx_h4_marker)
                (atx_h5_marker)
                (atx_h6_marker)
            ] @heading)

            [
                (list_marker_plus)
                (list_marker_minus)
                (list_marker_star)
            ] @list_marker

            (fenced_code_block) @code

            (block_quote (block_quote_marker) @quote_marker)
            (block_quote (paragraph (inline (block_continuation) @quote_marker)))

            (pipe_table_header) @table_head
            (pipe_table_delimiter_row) @table_delim
            (pipe_table_row) @table_row
        ]],
      headings = { '󰖙', '󰈸', '▶', '✺', '', '⤷' },
      quote = '┃',
      bullets = {"●","○","◆","◇"},
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
        -- Quote character in a block quote
        quote = '@markup.quote',
      },
    })
  end,
}
