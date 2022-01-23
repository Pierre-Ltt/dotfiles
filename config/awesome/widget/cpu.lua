local wibox = require('wibox')
local gears = require('gears')
local naughty = require('naughty')
local theme = require ('theme.theme')

local arc_height = 50
local arc_width = 50

local arc_progress_load = function()
    return function(cr, height, width)
        local end_angle = 3*math.pi/4 + (6*math.pi/4) * (height / 50)
       gears.shape.arc(cr,arc_height,width,15,3*math.pi/4, end_angle) 
    end
end

local arc_progress = function()
    return function(cr, height, width)
       gears.shape.arc(cr,height,width,15,3*math.pi/4, math.pi/4) 
    end
end

local cpu_bar= wibox.widget {
        widget = wibox.widget.progressbar,
        forced_width = arc_width,
        forced_height = arc_height,
        shape = arc_progress(),
        bar_shape = arc_progress_load(),
        max_value = 100,
        value = 0,
        color = theme.battery_bar_charging,
        background_color = theme.bg_focus
}

local cpu_percentage = wibox.widget {
    widget= wibox.widget.textbox,
    text=""
}

local cpu_widget = wibox.widget{
    {
        widget = cpu_percentage
    },
    {
        widget = cpu_bar
    },
    layout = wibox.layout.fixed.horizontal
}

awesome.connect_signal("cpu::load", function(load)
    cpu_bar.value=load
    cpu_percentage.text = "🖥 "..load.."% "
end)

return cpu_widget