local wezterm = require("wezterm")
local act = wezterm.action

local config = {
  font = wezterm.font("JetBrainsMono Nerd Font"),
  font_size = 13.0,
  color_scheme = "Catppuccin Mocha",
  hide_tab_bar_if_only_one_tab = true,
  use_fancy_tab_bar = false,
  adjust_window_size_when_changing_font_size = false,
  scrollback_lines = 10000,
  window_padding = {
    left = 10,
    right = 10,
    top = 8,
    bottom = 8,
  },
  keys = {
    { key = "Enter", mods = "ALT", action = act.ToggleFullScreen },
  },
}

if wezterm.target_triple:find("windows") then
  config.default_prog = { "wsl.exe", "~" }
end

return config
