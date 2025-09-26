-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices.

-- For example, changing the initial geometry for new windows:
config.initial_cols = 120
config.initial_rows = 28

-- or, changing the font size and color scheme.
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

-- Finally, return the configuration to wezterm:
return config
