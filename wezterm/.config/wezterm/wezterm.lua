local wezterm = require 'wezterm'
local act = wezterm.action
local config = {}

config.audible_bell = 'Disabled'
config.color_scheme = 'Modus-Operandi'
config.window_background_opacity = 1
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = true
config.status_update_interval = 1000
config.window_frame = {
  font = wezterm.font { family = 'monospace', scale = 0.85 },
}

-- config.window_background_image = '/home/navin/Pictures/goku.jpg'
-- config.window_background_image_hsb = {
--   brightness = 0.04,
-- }

config.window_decorations = "NONE"
config.window_close_confirmation = "AlwaysPrompt"
config.scrollback_lines = 5000
config.default_workspace = "main"
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}
-- Dim inactive panes
config.inactive_pane_hsb = {
  saturation = 0.64,
  brightness = 0.5
}

config.font = wezterm.font_with_fallback({
  { family = "monospace",  scale = 1, weight = "Regular", },
  { family = "Symbols Nerd Font",  scale = 1, weight = "Regular", },
})
config.use_dead_keys = false
-- config.disable_default_key_bindings = true
config.leader = { key="a", mods="CTRL" }
config.hide_tab_bar_if_only_one_tab = false

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
      win:perform_action(act.SendKey({key=key, mods=mods}), pane)
    end
  end

  return {key=key, mods=mods, action=wezterm.action_callback(callback)}
end

config.keys = {
  { key = "Enter",  mods = "ALT",       action = act.DisableDefaultAssignment },
  { key = "a", mods = "LEADER|CTRL",  action=act{SendString="\x01"}},
  { key = "-", mods = "LEADER",       action=act{SplitVertical={domain="CurrentPaneDomain"}}},
  { key = "\\",mods = "LEADER",       action=act{SplitHorizontal={domain="CurrentPaneDomain"}}},
  { key = "s", mods = "LEADER",       action=act{SplitVertical={domain="CurrentPaneDomain"}}},
  { key = "v", mods = "LEADER",       action=act{SplitHorizontal={domain="CurrentPaneDomain"}}},
  { key = "z", mods = "LEADER",       action="TogglePaneZoomState" },
  { key = "c", mods = "LEADER",       action=act{SpawnTab="CurrentPaneDomain"}},
  { key = "l", mods = "LEADER",       action=act.ActivateLastTab},
  { key = "w", mods = "LEADER",       action = act.ShowTabNavigator },
  { key = "s", mods = "LEADER",       action = act.ShowLauncherArgs{flags="FUZZY|WORKSPACES|LAUNCH_MENU_ITEMS"} },
  { key = "H", mods = "LEADER|SHIFT", action=act{AdjustPaneSize={"Left", 5}}},
  { key = "J", mods = "LEADER|SHIFT", action=act{AdjustPaneSize={"Down", 5}}},
  { key = "K", mods = "LEADER|SHIFT", action=act{AdjustPaneSize={"Up", 5}}},
  { key = "L", mods = "LEADER|SHIFT", action=act{AdjustPaneSize={"Right", 5}}},
  { key = "&", mods = "LEADER|SHIFT", action=act{CloseCurrentTab={confirm=true}}},
  { key = "x", mods = "LEADER",       action=act{CloseCurrentPane={confirm=true}}},
  { key = '[', mods = 'LEADER', action = act.ActivateCopyMode },
  {
    key = 'g',
    mods = 'LEADER',
    action = act.SpawnCommandInNewTab {
      args = { '/usr/bin/lazygit' },
    },
  },
  {
    key = 'G',
    mods = 'LEADER',
    action = act.SpawnCommandInNewTab {
      args = { '/usr/bin/gh', 'dash' },
    },
  },
  {
    key = 'F',
    mods = 'LEADER|SHIFT',
    action = act.SpawnCommandInNewTab {
      args = { '/usr/bin/yazi' },
    },
  },
  {
    key = 'd',
    mods = 'LEADER',
    action = act.SpawnCommandInNewTab {
      args = { '/usr/bin/git', 'dm' },
    },
  },
  {
    key = 'j',
    mods = 'LEADER',
    action = act.SpawnCommandInNewTab {
      args = { '/usr/bin/jira', 'lf', 'mine' },
    },
  },
  {
    key = 'J',
    mods = 'LEADER|SHIFT',
    action = act.SpawnCommandInNewTab {
      args = { '/usr/bin/jira', 'sprint' },
    },
  },
  {
    key = 'T',
    mods = 'LEADER|SHIFT',
    action = act.SpawnCommandInNewTab {
      args = { '/home/navin/.local/bin/twc' },
    },
  },
  {
    key = 't',
    mods = 'LEADER',
    action = act.SpawnCommandInNewTab {
      args = { '/usr/bin/taskwarrior-tui' },
    },
  },
  {
    key = 'm',
    mods = 'LEADER',
    action = act.SpawnCommandInNewTab {
      args = { '/usr/bin/neomutt' },
    },
  },
  {
    key = 'f',
    mods = 'LEADER',
    action = act.QuickSelectArgs{
      label = 'open url',
      patterns = { 'https?://[a-zA-Z0-9.:/_-]+' },
      action = wezterm.action_callback(function(window, pane)
        local url = window:get_selection_text_for_pane(pane)
        wezterm.open_with(url)
      end),
    },
  },
  {
    key = 'W',
    mods = 'LEADER|SHIFT',
    action = act.PromptInputLine {
      description = wezterm.format {
        { Attribute = { Intensity = 'Bold' } },
        { Foreground = { AnsiColor = 'Fuchsia' } },
        { Text = 'Enter name for new workspace' },
      },
      action = wezterm.action_callback(function(window, pane, line)
        -- line will be `nil` if they hit escape without entering anything
        -- An empty string if they just hit enter
        -- Or the actual line of text they wrote
        if line then
          window:perform_action(
            act.SwitchToWorkspace {
              name = line,
            },
            pane
          )
        end
      end),
    },
  },
  -- alt navigation
  bind_if(is_outside_vim, 'h', 'ALT', act.ActivatePaneDirection('Left')),
  bind_if(is_outside_vim, 'j', 'ALT', act.ActivatePaneDirection('Down')),
  bind_if(is_outside_vim, 'k', 'ALT', act.ActivatePaneDirection('Up')),
  bind_if(is_outside_vim, 'l', 'ALT', act.ActivatePaneDirection('Right')),
  {
    key = '!',
    mods = 'LEADER|SHIFT',
    action = act.SwitchToWorkspace {
      name = 'main',
    },
  },
  {
    key = '@',
    mods = 'LEADER|SHIFT',
    action = act.SwitchToWorkspace {
      name = 'notes',
      spawn = {
        cwd = wezterm.home_dir .. '/Documents/notes',
        args = { "nvim", "index.md" }
      },
    },
  },
  {
    key = '#',
    mods = 'LEADER|SHIFT',
    action = act.Multiple {
      act.SwitchToWorkspace {
        name = 'devstack',
        spawn = {
          cwd = wezterm.home_dir .. '/work/master-devstack/',
          args = {
            "sh",
            "-c",
            "wezterm cli spawn --cwd=edx-platform && wezterm cli spawn --cwd=devstack"
          },
        },
      },
    },
  },
  -- Create a new workspace with a random name and switch to it
  { key = ')', mods = 'LEADER|SHIFT', action = act.SwitchToWorkspace },
}
for i = 1, 9 do
  table.insert(config.keys, {
    key = tostring(i),
    mods = "LEADER",
    action = act.ActivateTab(i - 1)
  })
end

function os.capture(cmd, raw)
    local handle = assert(io.popen(cmd, 'r'))
    local output = assert(handle:read('*a'))

    handle:close()

    if raw then
        return output
    end

    output = string.gsub(
        string.gsub(
            string.gsub(output, '^%s+', ''),
            '%s+$',
            ''
        ),
        '[\n\r]+',
        ' '
    )

   return output
end

-- Current working directory
local basename = function(s)
  -- Nothing a little regex can't fix
  s = s:gsub("%/$", "")
  return string.gsub(s, "(.*[/\\])(.*)", "%2")
end

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  local title = basename(tab.active_pane.current_working_dir)
  return {
    { Text = wezterm.nerdfonts.md_folder .. " " .. title },
  }
end)

wezterm.on("update-status", function(window, pane)
  -- Workspace name
  local stat = window:active_workspace()
  local stat_color = "#f7768e"
  -- It's a little silly to have workspace name all the time
  -- Utilize this to display LDR or current key table name
  if window:active_key_table() then
    stat = window:active_key_table()
    stat_color = "#7dcfff"
  end
  if window:leader_is_active() then
    stat = "LDR"
    stat_color = "#bb9af7"
  end

  -- Current command
  local cmd = pane:get_foreground_process_name()
  cmd = cmd and basename(cmd) or ""

  local cur_tracked = os.capture("echo $(timew | grep 'Total') | cut -d' ' -f2", false);
  local total_tracked = os.capture("echo $(timew day | grep 'Tracked') | cut -d' ' -f2", false);

  -- Time
  local time = wezterm.strftime("%H:%M")

  -- Left status (left of the tab line)
  window:set_left_status(wezterm.format({
    { Foreground = { Color = stat_color } },
    { Text = "  " },
    { Text = wezterm.nerdfonts.oct_table .. "  " .. stat },
    { Text = " " },
  }))

  -- Right status
  window:set_right_status(wezterm.format({
    -- Wezterm has a built-in nerd fonts
    -- https://wezfurlong.org/wezterm/config/lua/wezterm/nerdfonts.html
    { Text = wezterm.nerdfonts.oct_stopwatch .. " " .. cur_tracked },
    { Text = " | " },
    { Text = wezterm.nerdfonts.md_calendar_clock_outline .. " Total: " .. total_tracked },
    { Text = " | " },
    { Foreground = { Color = "#e0af68" } },
    { Text = wezterm.nerdfonts.fa_code .. " " .. cmd },
    "ResetAttributes",
    { Text = " | " },
    { Text = wezterm.nerdfonts.md_clock .. " " .. time },
    { Text = "  " },
  }))
end)

--[[ Appearance setting for when I need to take pretty screenshots
config.enable_tab_bar = false
config.window_padding = {
  left = '0.5cell',
  right = '0.5cell',
  top = '0.5cell',
  bottom = '0cell',

}
--]]

config.quick_select_patterns = {
  -- match things that look like sha1 hashes
  -- (this is actually one of the default patterns)
  '[0-9a-f]{7,40}',
  'https?://[a-zA-Z0-9.:/_-]+',
  'BB-[0-9]+',
  'STAR-[0-9]+',
  'FAL-[0-9]+',
  'MNG-[0-9]+',
}

-- Use the defaults as a base
config.hyperlink_rules = wezterm.default_hyperlink_rules()

-- make task numbers clickable
-- the first matched regex group is captured in $1.
table.insert(config.hyperlink_rules, {
  regex = [[\b(BB-\d+)\b]],
  format = 'https://tasks.opencraft.com/browse/$1',
})

-- make username/project paths clickable. this implies paths like the following are for github.
-- ( "nvim-treesitter/nvim-treesitter" | wbthomason/packer.nvim | wez/wezterm | "wez/wezterm.git" )
-- as long as a full url hyperlink regex exists above this it should not match a full url to
-- github or gitlab / bitbucket (i.e. https://gitlab.com/user/project.git is still a whole clickable url)
table.insert(config.hyperlink_rules, {
  regex = [[["]?([\w\d]{1}[-\w\d]+)(/){1}([-\w\d\.]+)["]?]],
  format = 'https://www.github.com/$1/$3',
})

config.launch_menu = {
  {
    args = { 'btop' },
  },
  {
    label = "lazygit",
    args = { '/usr/bin/lazygit' },
  },
}

return config
