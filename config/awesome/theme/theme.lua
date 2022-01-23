local gears = require("gears")
local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local gfs = require("gears.filesystem")
local layout_icon_path = os.getenv("HOME") .. "/.config/awesome/themes/layout/"
local titlebar_icon_path = os.getenv("HOME") .. "/.config/awesome/themes/titlebar/"
local taglist_icon_path = os.getenv("HOME") .. "/.config/awesome/themes/taglist/"
local tip = titlebar_icon_path --alias to save time/space
local xrdb = xresources.get_current_theme()
local naughty = require("naughty")
-- local theme = dofile(themes_path.."default/theme.lua")
local theme = {}

-- Set theme wallpaper.
-- It won't change anything if you are using feh to set the wallpaper like I do.
theme.wallpaper = function(s)
    local path = os.getenv("HOME") .. "/.config/awesome/theme/wallpaper.jpg"
    gears.wallpaper.maximized(path, s)
end

-- Set the theme font. This is the font that will be used by default in menus, bars, titlebars etc.
-- theme.font          = "sans 11"
theme.font          = "FiraCode NF 10"

-- This is how to get other .Xresources values(beyond colors 0-15, or custom variables)
-- local cool_color = awesome.xrdb_get_value("", "color16")

local background = "#1d1f21"
local current_line = "#282a2e"
local selection = "#373b41"
local foreground = "#c5c8c6"
local comment = "#969896"
local red = "#f28fad"
local orange = "#f8bd96"
local yellow = "#fae3b0"
local green = "#abe9b3"
local aqua = "#b5E8E0"
local blue = "#96cdfb"
local purple = "#c9cbff"

theme.bg_dark       = background
theme.bg_normal     = current_line
theme.bg_focus      = selection
theme.bg_urgent     = selection
theme.bg_minimize   = selection
theme.bg_systray    = background

theme.fg_normal     = comment
theme.fg_focus      = foreground
theme.fg_urgent     = red
theme.fg_minimize   = foreground

-- Gaps
theme.useless_gap   = dpi(3)
-- This could be used to manually determine how far away from the
-- screen edge the bars / notifications should be.
theme.screen_margin = dpi(5)

-- Borders
theme.border_width  = 4
-- theme.border_color = x.color0
theme.border_normal = comment
theme.border_focus  = blue
-- Rounded corners
theme.border_radius = dpi(7)

-- Titlebars
theme.titlebars_enabled = false

-- Notifications
theme.notification_font = "FiraCode NF"
theme.notification_position = "top_right"
theme.notification_border_width = dpi(1)
theme.notification_border_radius = theme.border_radius
theme.notification_border_color = blue
theme.notification_bg = background
theme.notification_fg = foreground
theme.notification_crit_bg = background
theme.notification_crit_fg = yellow
theme.notification_icon_size = dpi(40)
theme.notification_margin = dpi(16)
theme.notification_opacity = 0.9
theme.notification_font = "FiraCode NF 8"
theme.notification_padding = theme.screen_margin * 2
theme.notification_spacing = theme.screen_margin * 4
theme.notification_max_width = dpi(400)
theme.notification_max_height = dpi(100)

theme.battery_bar_charging = green
theme.battery_bar_ok = green
theme.battery_bar_low = yellow
theme.battery_bar_critical = red

-- Edge snap
theme.snap_shape = gears.shape.rectangle
theme.snap_bg = foreground
theme.snap_border_width = dpi(3)

-- Widget separator
theme.separator_text = "|"
theme.separator_fg = blue

-- Wibar(s)
-- Keep in mind that these settings could be ignored by the bar theme
theme.wibar_position = "top"
theme.wibar_height = dpi(45)
theme.wibar_fg = foreground
theme.wibar_bg = background 
--theme.wibar_opacity = 0.7
theme.wibar_border_color = blue
theme.wibar_border_width = dpi(2)
theme.wibar_border_radius = dpi(10)
-- theme.wibar_width = dpi(380)

theme.prefix_fg = foreground

-- Noodle Text Taglist
theme.taglist_text_font = "FiraCode NF 25"
theme.taglist_text_color_empty  = { background, background, background, background, background, background, background}
theme.taglist_text_color_occupied  = {comment, comment, comment, comment, comment, comment}
theme.taglist_text_color_focused  = {foreground, foreground, foreground, foreground, foreground, foreground}
theme.taglist_text_color_urgent   = { orange, orange, orange, orange, orange, orange}

-- Prompt
theme.prompt_fg = foreground

-- Text Taglist (default)
theme.taglist_font = "FiraCode NF 14"
theme.taglist_bg_focus = background
theme.taglist_fg_focus = blue
theme.taglist_bg_occupied = background 
theme.taglist_fg_occupied = foreground
theme.taglist_bg_empty = background
theme.taglist_fg_empty = comment
theme.taglist_bg_urgent = background
theme.taglist_fg_urgent = orange
theme.taglist_disable_icon = true
-- Generate taglist squares:
local taglist_square_size = dpi(0)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
    taglist_square_size, theme.fg_focus
)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
    taglist_square_size, theme.fg_normal
)

return theme