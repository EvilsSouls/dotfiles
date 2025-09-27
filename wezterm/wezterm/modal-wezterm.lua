local wezterm = require("wezterm")
local modal = wezterm.plugin.require("https://github.com/MLFlexer/modal.wezterm")

modal.apply_to_config(config)
modal.set_default_keys(config)
