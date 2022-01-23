local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")
local naughty = require("naughty")
local tags = require("elements.tags")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local theme = require('theme.theme')

local bar = {}

-- {{{ Wibar
-- Create a textclock widget
local clock = wibox.widget.textclock("📅 %d/%m  ⏱ %H:%M ")

local battery_widget = require('widget.battery')
local updates_widget = require('widget.updates')
local cpu_widget = require('widget.cpu')

local separator = wibox.widget {
    widget = wibox.widget.textbox,
    text = "      "
}

local create_left_bar = function(s)
    tags.generate_tags(s)
    local systray = wibox.widget.systray()

    s.left_wibox = awful.wibar({
        screen=s,
        height=dpi(25),
        bg= "#1d1f21",
        visible=true,
        type="desktop",
    })

    -- Add widgets to the wibox
    s.left_wibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            s.mytaglist,
        },
        nil,
        {
            layout = wibox.layout.fixed.horizontal,
            updates_widget,
            separator,
            cpu_widget,
            separator,
            battery_widget,
            separator,
            clock,
            separator,
            systray,
        }
    }
end

bar.create_bar = function(s)
    create_left_bar(s)
end

return bar
