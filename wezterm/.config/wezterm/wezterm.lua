local wezterm = require 'wezterm'
local config = {}

config.color_scheme = 'Gruvbox Light'
config.window_background_opacity = 0.9
config.hide_tab_bar_if_only_one_tab = true
config.window_frame = {
  font = wezterm.font { family = 'monospace', weight = 'Bold' },

  -- The size of the font in the tab bar.
  -- Default to 10.0 on Windows but 12.0 on other systems
  font_size = 8.0,
}
config.window_decorations = "NONE"
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

config.font = wezterm.font('monospace')
config.font_size = 11.0
config.line_height = 1.1
config.use_dead_keys = false
-- config.disable_default_key_bindings = true
config.leader = { key="a", mods="CTRL" }
config.hide_tab_bar_if_only_one_tab = true

local function is_inside_vim(pane)
  local tty = pane:get_tty_name()
  if tty == nil then return false end

  local success, stdout, stderr = wezterm.run_child_process
    { 'sh', '-c',
      'ps -o state= -o comm= -t' .. wezterm.shell_quote_arg(tty) .. ' | ' ..
      'grep -iqE \'^[^TXZ ]+ +(\\S+\\/)?g?(view|l?n?vim?x?)(diff)?$\'' }

  return success
end

local function is_outside_vim(pane) return not is_inside_vim(pane) end

local function bind_if(cond, key, mods, action)
  local function callback (win, pane)
    if cond(pane) then
      win:perform_action(action, pane)
    else
      win:perform_action(wezterm.action.SendKey({key=key, mods=mods}), pane)
    end
  end

  return {key=key, mods=mods, action=wezterm.action_callback(callback)}
end

config.keys = {
  { key = "Enter",  mods = "ALT",       action = wezterm.action.DisableDefaultAssignment },
  { key = "a", mods = "LEADER|CTRL",  action=wezterm.action{SendString="\x01"}},
  { key = "-", mods = "LEADER",       action=wezterm.action{SplitVertical={domain="CurrentPaneDomain"}}},
  { key = "\\",mods = "LEADER",       action=wezterm.action{SplitHorizontal={domain="CurrentPaneDomain"}}},
  { key = "s", mods = "LEADER",       action=wezterm.action{SplitVertical={domain="CurrentPaneDomain"}}},
  { key = "v", mods = "LEADER",       action=wezterm.action{SplitHorizontal={domain="CurrentPaneDomain"}}},
  { key = "o", mods = "LEADER",       action="TogglePaneZoomState" },
  { key = "z", mods = "LEADER",       action="TogglePaneZoomState" },
  { key = "c", mods = "LEADER",       action=wezterm.action{SpawnTab="CurrentPaneDomain"}},
  { key = "l", mods = "LEADER",       action=wezterm.action.ActivateLastTab},
  { key = "H", mods = "LEADER|SHIFT", action=wezterm.action{AdjustPaneSize={"Left", 5}}},
  { key = "J", mods = "LEADER|SHIFT", action=wezterm.action{AdjustPaneSize={"Down", 5}}},
  { key = "K", mods = "LEADER|SHIFT", action=wezterm.action{AdjustPaneSize={"Up", 5}}},
  { key = "L", mods = "LEADER|SHIFT", action=wezterm.action{AdjustPaneSize={"Right", 5}}},
  { key = "1", mods = "LEADER",       action=wezterm.action{ActivateTab=0}},
  { key = "2", mods = "LEADER",       action=wezterm.action{ActivateTab=1}},
  { key = "3", mods = "LEADER",       action=wezterm.action{ActivateTab=2}},
  { key = "4", mods = "LEADER",       action=wezterm.action{ActivateTab=3}},
  { key = "5", mods = "LEADER",       action=wezterm.action{ActivateTab=4}},
  { key = "6", mods = "LEADER",       action=wezterm.action{ActivateTab=5}},
  { key = "7", mods = "LEADER",       action=wezterm.action{ActivateTab=6}},
  { key = "8", mods = "LEADER",       action=wezterm.action{ActivateTab=7}},
  { key = "9", mods = "LEADER",       action=wezterm.action{ActivateTab=8}},
  { key = "&", mods = "LEADER|SHIFT", action=wezterm.action{CloseCurrentTab={confirm=true}}},
  { key = "x", mods = "LEADER",       action=wezterm.action{CloseCurrentPane={confirm=true}}},
  { key = '[', mods = 'LEADER', action = wezterm.action.ActivateCopyMode },
  -- alt navigation
  bind_if(is_outside_vim, 'h', 'ALT', wezterm.action.ActivatePaneDirection('Left')),
  bind_if(is_outside_vim, 'j', 'ALT', wezterm.action.ActivatePaneDirection('Down')),
  bind_if(is_outside_vim, 'k', 'ALT', wezterm.action.ActivatePaneDirection('Up')),
  bind_if(is_outside_vim, 'l', 'ALT', wezterm.action.ActivatePaneDirection('Right')),
}

return config
