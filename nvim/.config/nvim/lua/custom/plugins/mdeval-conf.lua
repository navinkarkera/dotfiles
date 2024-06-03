return {
  "jubnzv/mdeval.nvim",
  config = function()
    require 'mdeval'.setup({
      require_confirmation=false,
      allowed_file_types={'bash', 'python', 'lua', 'hurl', 'hurlv', 'hurlt', 'hurltv'},
      eval_options={
        hurl = {
          command = {"hurl", "--no-color", "--variables-file", "/home/navin/.local/share/vars.env"},
          language_code = "hurl",
          exec_type = "interpreted",
          extension = "hurl",
        },
        hurlv = {
          command = {"hurl", "--no-color", "-v", "--variables-file", "/home/navin/.local/share/vars.env"},
          language_code = "hurlv",
          exec_type = "interpreted",
          extension = "hurl",
        },
        hurlt = {
          command = {"hurl", "--no-color", "--test", "--variables-file", "/home/navin/.local/share/vars.env"},
          language_code = "hurlt",
          exec_type = "interpreted",
          extension = "hurl",
        },
        hurltv = {
          command = {"hurl", "--no-color", "-v", "--test", "--variables-file", "/home/navin/.local/share/vars.env"},
          language_code = "hurltv",
          exec_type = "interpreted",
          extension = "hurl",
        },
      },
    })
  end
}
