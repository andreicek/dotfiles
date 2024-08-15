local wezterm = require 'wezterm'
local config = wezterm.config_builder()

local function move_pane(key, direction)
  return {
    key = key,
    mods = 'LEADER',
    action = wezterm.action.ActivatePaneDirection(direction),
  }
end

config.color_scheme = 'Solarized Light (Gogh)'
config.font = wezterm.font({ family = 'Berkeley Mono' })
config.font_size = 14

config.window_decorations = 'RESIZE'

config.window_frame = {
  font = wezterm.font({ family = 'Berkeley Mono', weight = 'Bold' }),
  font_size = 12,
}

config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }

config.keys = {
  {
    key = '|',
    mods = 'LEADER',
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  {
    key = '-',
    mods = 'LEADER',
    action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  {
    key = 'z',
    mods = 'LEADER',
    action = wezterm.action.TogglePaneZoomState,
  },
  move_pane('DownArrow', 'Down'),
  move_pane('UpArrow', 'Up'),
  move_pane('LeftArrow', 'Left'),
  move_pane('RightArrow', 'Right'),
}

config.inactive_pane_hsb = {
  saturation = 1,
  brightness = 1,
}

return config
