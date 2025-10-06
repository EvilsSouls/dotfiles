-- Pull in the wezterm API
local wezterm = require 'wezterm'
local config = wezterm.config_builder()

require 'hyperlink-snippet'
local bar = wezterm.plugin.require("https://github.com/adriankarlen/bar.wezterm")
--require 'modal-wezterm'

config.enable_wayland = true

config.initial_cols = 120
config.initial_rows = 28

-- Font and Color Scheme
config.font_size = 11.25
config.font = wezterm.font_with_fallback {
  'JetBrainsMono Nerd Font',
  'JetBrains Mono',
  'Noto Color Emoji',
  'Symbols Nerd Font Mono',
}
config.color_scheme = 'Default Dark (base16)'
config.inactive_pane_hsb = {
  saturation = 0.9,
  brightness = 0.8,
}
--config.window_background_opacity = 0.9
--config.kde_window_background_blur = true

-- Tab Bar
config.use_fancy_tab_bar = true
config.tab_bar_at_bottom = false
config.hide_tab_bar_if_only_one_tab = true
config.colors = {tab_bar = {active_tab = {
  bg_color = '#181818',
  fg_color = '#c0c0c0',
  underline = 'Single',
}}}
bar.apply_to_config(config)

-- Finally, return the configuration to wezterm:
return config
