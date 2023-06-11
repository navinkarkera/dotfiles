return {
  "jubnzv/mdeval.nvim",
  config = function()
    require 'mdeval'.setup({
      require_confirmation=false,
      allowed_file_types={'bash', 'python', 'lua'},
      eval_options={},
    })
  end
}
