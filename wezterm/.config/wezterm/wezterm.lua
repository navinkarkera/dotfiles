local wezterm = require 'wezterm'
local config = {}

config.color_scheme = 'Gruvbox Light'
config.window_background_opacity = 0.9
config.hide_tab_bar_if_only_one_tab = true
config.window_frame = {
  font = wezterm.font { family = 'monospace', weight = 'Bold' },

  -- The size of the font in the tab bar.
  -- Default to 10.0 on Windows but 12.0 on other systems
  font_size = 6.0,
}

config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

config.font = wezterm.font('monospace')
config.font_size = 10.0
config.line_height = 1.1
config.use_dead_keys = false
config.disable_default_key_bindings = true
-- config.keys = {
--   { key = "=",  mods = "CTRL",       action = wezterm.action { CloseCurrentPane = { confirm = true } } },
-- }

return config
