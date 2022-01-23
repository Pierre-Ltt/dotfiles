-- This file allows awesome to check for 
local awful = require('awful')
local naughty = require('naughty')

local update_interval = 60
local battery = 'BAT0'
local charger = 'ADP0'

local launch_acpid = [[
    sh -c '
    acpi_listen | grep --line-buffered ac_adapter
    '
]]

awful.widget.watch("cat /sys/class/power_supply/"..battery.."/capacity", update_interval, function(_, stdout)
    awesome.emit_signal('battery::capacity', tonumber(stdout))
end)

local emit_charger_info = function()
    awful.spawn.easy_async_with_shell("cat /sys/class/power_supply/"..charger.."/online", function(stdout)
        awesome.emit_signal("battery::charger", tonumber(stdout) == 1)
    end)
end

emit_charger_info()

awful.spawn.easy_async_with_shell("ps x | grep \"acpi_listener\" | grep -v grep | awk '{print $1}' | xargs kill", function ()


    awful.spawn.with_line_callback(launch_acpid, {
        stdout = function(_)
            emit_charger_info()
        end
    })
end)