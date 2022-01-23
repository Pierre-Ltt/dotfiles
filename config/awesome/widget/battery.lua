local gears = require('gears')
local wibox = require('wibox')
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local theme = require('theme.theme')

local battery_bar = wibox.widget {
    max_value = 100,
    value = 0,
    forced_width = dpi(40),
    margins={
        top=25,
        bottom= 25,
    },
    shape = gears.shape.rounded_bar,
    bar_shape = gears.shape.rounded_bar,
    color = theme.separator_fg,
    background_color = theme.bg_focus,
    widget = wibox.widget.progressbar,
}

local battery_percentage = wibox.widget {
    widget = wibox.widget.textbox,
    text = ""
}

local charger_status = wibox.widget {
    widget = wibox.widget.textbox,
    text = "",
}

awesome.connect_signal("battery::capacity", function(percentage)
    battery_bar.value = percentage
    local emoji = ""

    if percentage <= 10 then
        battery_bar.color = theme.battery_bar_critical
        battery_bar.border_color = theme.battery_bar_critical
        emoji = "❌"
    elseif percentage <= 20 then
        battery_bar.color = theme.battery_bar_low
        battery_bar.border_color = theme.battery_bar_low
        emoji = "❌"
    else
        battery_bar.color = theme.battery_bar_ok
        battery_bar.border_color = theme.battery_bar_ok
        emoji = "🔋"
    end
    battery_percentage.text = emoji.." "..percentage.."% "
end)

awesome.connect_signal("battery::charger", function(status)
    if status then
        charger_status.text = "⚡"
        battery_bar.color = theme.battery_bar_charging
        battery_bar.border_color = theme.battery_bar_charging
    else
        charger_status.text = ""
    end
end)

local battery_widget = wibox.widget {
    {
        widget = battery_percentage,
    },
    {
        widget = battery_bar,
    },
    {
        widget = charger_status
    },
    layout = wibox.layout.fixed.horizontal,
    background_color = theme.bg_focus
}

return battery_widget