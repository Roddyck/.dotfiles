-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

config.window_decorations = "RESIZE"
config.hide_tab_bar_if_only_one_tab = true

-- For example, changing the color scheme:
config.color_scheme = 'Tokyo Night'
--config.color_scheme = 'rose-pine'

config.window_background_opacity = 0.7

config.window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
}

config.max_fps = 120

-- and finally, return the configuration to wezterm
return config
