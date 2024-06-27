local wezterm = require 'wezterm'

local config = {}
local act = wezterm.action

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.enable_wayland = true
config.color_scheme = 'MaterialDesignColors'

config.window_background_opacity = 0.80
config.font_size = 12

config.keys = {
  {
    key = 't',
    mods = 'SHIFT|CTRL',
    action = act.SpawnTab 'CurrentPaneDomain',
  },
}

for i = 1, 8 do
  table.insert(config.keys, {
    key = tostring(i),
    mods = 'ALT',
    action = act.ActivateTab(i - 1),
  })
end

return config
