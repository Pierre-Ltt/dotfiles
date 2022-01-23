local awful = require("awful")
local gears = require("gears")
local shared = require("shared")
local naughty = require("naughty")

local client = {}

client.keys = gears.table.join(
    awful.key({ shared.modkey,           }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
            if c.fullscreen then
                naughty.suspend()
            else
                naughty.resume()
            end
        end,
        {description = "toggle fullscreen", group = "client"}),
    awful.key({ shared.modkey, "Shift"   }, "q",      function (c) c:kill()                         end,
              {description = "close", group = "client"}),
    awful.key({ shared.modkey,           }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "(un)maximize", group = "client"}),
    awful.key({ shared.modkey, "Shift" }, "f",  awful.client.floating.toggle                     ,
              {description = "toggle floating", group = "client"})
)

return client