local awful = require('awful')
local gears = require('gears')
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local wibox = require("wibox")

local tags = {}

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
                    awful.button({ }, 1, function(t) t:view_only() end),
                    awful.button({ modkey }, 1, function(t)
                                              if client.focus then
                                                  client.focus:move_to_tag(t)
                                              end
                                          end),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, function(t)
                                              if client.focus then
                                                  client.focus:toggle_tag(t)
                                              end
                                          end),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
                )

tags.generate_tags = function (s)
    -- Each screen has its own tag table.
    awful.tag({ "", "", "", "", "", ""}, s, awful.layout.suit.spiral)

    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        layout  = {
            spacing = 12,
            spacing_widget = {
                opacity = 0,
                widget = wibox.widget.separator,
            },
            layout  = wibox.layout.fixed.horizontal
        },
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        style = {
            shape = gears.shape.circle
        }
    }
end

return tags