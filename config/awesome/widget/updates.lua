local wibox = require('wibox')
local theme = require('theme.theme')

local updates_widget = wibox.widget {
    text = "",
    background_color = theme.bg_focus,
    widget = wibox.widget.textbox
}

awesome.connect_signal("package::updates", function(nb_updates)
    updates_widget.text = "📦 "..nb_updates
end)


return updates_widget