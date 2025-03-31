local wezterm = require 'wezterm'


wezterm.on('window-config-reloaded', function(window, pane)
  window:toast_notification("wezterm", "Config reloaded!", nil, 4000)
end)



return {
  default_prog = { "D:\\My Program Files\\Git\\bin\\bash.exe", "-l"},

  font_size = 12.0,
  font = wezterm.font("D2Coding"),
  color_scheme = 'Catppuccin Mocha',

  keys = {
    { key = "Enter", mods = "ALT|SHIFT", action = wezterm.action.SplitVertical{domain="CurrentPaneDomain"} },
    { key = "Enter", mods = "CTRL|SHIFT", action = wezterm.action.SplitHorizontal{domain="CurrentPaneDomain"} },
    { key = "x", mods = "ALT", action = wezterm.action.CloseCurrentPane { confirm = true } },
    { key = "j", mods = "ALT", action = wezterm.action.ActivatePaneDirection("Left") },
    { key = "k", mods = "ALT", action = wezterm.action.ActivatePaneDirection("Down") },
    { key = "l", mods = "ALT", action = wezterm.action.ActivatePaneDirection("Up") },
    { key = ";", mods = "ALT", action = wezterm.action.ActivatePaneDirection("Right") },
  },

  -- config_reload_watchlist = {
  --   wezterm.config_dir .. "/wezterm.lua",
  -- },
}
