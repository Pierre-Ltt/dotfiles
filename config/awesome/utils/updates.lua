local awful = require('awful')

local updates_command = [[
    sh -c '
    pacman -Qu | wc -l
    '
]]

awful.widget.watch(updates_command, 3600, function(_,stdout)
    awesome.emit_signal("package::updates", tonumber(stdout))
end)