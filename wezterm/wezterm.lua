-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

config.automatically_reload_config = true

wezterm.on('window-config-reloaded', function(window, pane)
    wezterm.log_info 'the config was reloaded for this window!'
end)

-- bell
config.audible_bell = "Disabled"

-- scroll backline
config.scrollback_lines = 100000000

-- ime
config.use_ime = true

config.window_decorations = 'RESIZE'
config.font_size = 14

-- This is where you actually apply your config choices
config.color_scheme = "Dracula (Official)"
-- config.color_scheme = "Dracula (Gogh)"
-- config.color_scheme = "Dracula+"
--config.color_scheme = "darkmatrix"

config.window_background_opacity = 0.75
config.macos_window_background_blur = 8

config.window_background_gradient = {
    -- Can be "Vertical" or "Horizontal".  Specifies the direction
    -- in which the color gradient varies.  The default is "Horizontal",
    -- with the gradient going from left-to-right.
    -- Linear and Radial gradients are also supported; see the other
    -- examples below
    -- orientation = "Vertical",
    orientation = { Linear = { angle = -50.0 } },

    -- Specifies the set of colors that are interpolated in the gradient.
    -- Accepts CSS style color specs, from named colors, through rgb
    -- strings and more
    -- colors = {
    --      "#0f0c29",
    --      "#302b63",
    --      "#24243e",
    --},
    colors = {
        "#000000",
        "#0f0c29",
        "#282a36",
    },
    -- colors = { "Inferno" },

    -- Instead of specifying `colors`, you can use one of a number of
    -- predefined, preset gradients.
    -- A list of presets is shown in a section below.
    -- preset = "Warm",

    -- Specifies the interpolation style to be used.
    -- "Linear", "Basis" and "CatmullRom" as supported.
    -- The default is "Linear".
    interpolation = "CatmullRom",

    -- How the colors are blended in the gradient.
    -- "Rgb", "LinearRgb", "Hsv" and "Oklab" are supported.
    -- The default is "Rgb".
    blend = "Rgb",

    -- To avoid vertical color banding for horizontal gradients, the
    -- gradient position is randomly shifted by up to the `noise` value
    -- for each pixel.
    -- Smaller values, or 0, will make bands more prominent.
    -- The default value is 64 which gives decent looking results
    -- on a retina macbook pro display.
    noise = 64,

    -- By default, the gradient smoothly transitions between the colors.
    -- You can adjust the sharpness by specifying the segment_size and
    -- segment_smoothness parameters.
    -- segment_size configures how many segments are present.
    -- segment_smoothness is how hard the edge is; 0.0 is a hard edge,
    -- 1.0 is a soft edge.

    segment_size = 11,
    segment_smoothness = 1.0,
}


config.window_frame = {
    inactive_titlebar_bg = "none",
    active_titlebar_bg = "none",
    inactive_titlebar_fg = "none",
    active_titlebar_fg = "none",
    inactive_titlebar_border_bottom = "none",
    active_titlebar_border_bottom = "none",
    button_fg = "#44475A",
    button_bg = "#282A36",
    button_hover_fg = "#F8F8F2",
    button_hover_bg = "#282A36",
}

-- タブバーの＋を消す
config.show_new_tab_button_in_tab_bar = false

config.colors = {
    foreground = "#00F515",
    tab_bar = {
        inactive_tab_edge = "none",
    }
}

config.window_padding = {
    left = 5,
    right = 5,
    top = 10,
    bottom = 5,
}

local SOLID_LEFT_ARROW = wezterm.nerdfonts.ple_left_half_circle_thick
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.ple_right_half_circle_thick
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
    local background = "#5c6d74"
    local foreground = "#FFFFFF"
    local edge_background = "none"
    local edge_foreground = background
    if tab.is_active then
        background = "#ae8b2d"
        foreground = "#FFFFFF"
    end

    local title = "   " .. wezterm.truncate_right(tab.active_pane.title, max_width - 1) .. "   "

    return {
        { Background = { Color = edge_background } },
        { Foreground = { Color = edge_foreground } },
        { Text = SOLID_LEFT_ARROW },
        { Background = { Color = background } },
        { Foreground = { Color = foreground } },
        { Text = title },
        { Background = { Color = edge_background } },
        { Foreground = { Color = edge_foreground } },
        { Text = SOLID_RIGHT_ARROW },
    }
end)

-- and finally, return the configuration to wezterm
return config
