local gears = require("gears")
local awful = require("awful")
local shared = require("shared")
local helpers = require('helpers')
local naughty = require("naughty")


local global_keys = {}

global_keys.keys = gears.table.join(
    awful.key({ shared.modkey,           }, "p",
        function ()
            awful.screen.focus_relative(-1)
        end,
    {description="Focus previous screen", group="screen"}),
    awful.key({ shared.modkey,           }, "n",
        function ()
            awful.screen.focus_relative(1)
        end,
    {description="Focus next screen", group="screen"}),
    awful.key({ shared.modkey,           }, "j",
        function ()
            awful.client.focus.bydirection('down')
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key({ shared.modkey,           }, "k",
        function ()
            awful.client.focus.bydirection('up')
        end,
        {description = "focus previous by index", group = "client"}
    ),
    awful.key({ shared.modkey,           }, "h",
        function ()
            awful.client.focus.bydirection('left')
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key({ shared.modkey,           }, "l",
        function ()
            awful.client.focus.bydirection("right")
        end,
        {description = "focus previous by index", group = "client"}
    ),

    awful.key({ shared.modkey, "Shift" }, "b",
        function ()
            awful.spawn("zsh -c ~/.local/scripts/bluetooth-menu")
        end,
        {description = "Run bluetooth menu script", group = "System"}
    ),

    -- Brightness control
    awful.key({}, "XF86MonBrightnessUp", 
        function () 
            awful.spawn.easy_async_with_shell("brightnessctl s +10%", function()
                helpers.notify_brightness()
            end)
        end,
        {description = "Increase brightness", group = "System"}
    ),
    awful.key({}, "XF86MonBrightnessDown", 
        function () 
            awful.spawn.easy_async_with_shell("brightnessctl s 10%-", function()
                helpers.notify_brightness()
            end) 
        end,
        {description = "Decrease brightness", group = "System"}
    ),

    -- Volume control
    awful.key({}, "XF86AudioRaiseVolume", 
        function () 
            awful.spawn.easy_async_with_shell("pamixer -i 10", function()
                helpers.notify_volume()
            end) 
        end,
        {description = "Increase volume", group = "System"}
    ),
    awful.key({}, "XF86AudioLowerVolume", 
        function () 
            awful.spawn.easy_async_with_shell("pamixer -d 10", function()
                helpers.notify_volume()
            end) 
        end,
        {description = "Decrease volume", group = "System"}
    ),
    awful.key({}, "XF86AudioMute", 
        function () 
            awful.spawn.easy_async_with_shell("pamixer --get-mute", function (stdout)
                local status = string.gsub(stdout, "\n", "")
                if status == "true" then
                    awful.spawn.with_shell("pamixer -u")
                else
                    awful.spawn.with_shell("pamixer -m")
                end
                helpers.notify_volume()
            end) 
            helpers.notify_volume()
        end,
        {description = "Mute volume", group = "System"}
    ),

    -- Layout manipulation
    awful.key({ shared.modkey, "Shift"   }, "j", function () awful.client.swap.bydirection('down')    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ shared.modkey, "Shift"   }, "k", function () awful.client.swap.bydirection('up')    end,
              {description = "swap with previous client by index", group = "client"}),
    awful.key({ shared.modkey, "Shift"   }, "h", function () awful.client.swap.bydirection('left')    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ shared.modkey, "Shift"   }, "l", function () awful.client.swap.bydirection('right')    end,
              {description = "swap with previous client by index", group = "client"}),
    awful.key({ shared.modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({ shared.modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),
    awful.key({ shared.modkey,           }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),
    awful.key({ shared.modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),

    -- Standard program
    awful.key({ shared.modkey,           }, "Return", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ shared.modkey,           }, "b", function () awful.spawn(browser) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ shared.modkey,           }, "d",
             function ()
                awful.spawn("discord")

                local screen = awful.screen.preferred()
                local tag = screen.tags[5]
                if tag then
                    tag:view_only()
                end
             end,
              {description = "Open discord", group="launcher"}),
    awful.key({ shared.modkey,           }, "s",
             function ()
                local screen = awful.screen.preferred()
                local tag = screen.tags[6]
                if tag then
                    tag:view_only()
                end

                awful.spawn("spotify")
             end,
              {description = "Open Spotify", group = "launcher"}),
    awful.key({ shared.modkey, "Shift" }, "Return", function() awful.spawn("rofi -show drun") end,
              {description = "Open Rofi", group = "launcher"}),
    awful.key({ shared.modkey, "Shift" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ shared.modkey, "Shift"   }, "e", awesome.quit,
              {description = "quit awesome", group = "awesome"}),

    -- Prompt
    awful.key({ shared.modkey },            "r",     function () awful.screen.focused().mypromptbox:run() end,
              {description = "run prompt", group = "launcher"})
)


for i = 1, 6 do
    global_keys.keys = gears.table.join(global_keys.keys,
        -- View tag only.
        awful.key({ shared.modkey }, "#" .. i + 8,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ shared.modkey, "Control" }, "#" .. i + 8,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ shared.modkey, "Shift" }, "#" .. i + 8,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"})
    )
end

global_keys.keys = gears.table.join(global_keys.keys,
    awful.key({ shared.modkey }, "#"..49,
                function ()
                    local screen = awful.screen.focused()
                    local tag = screen.tags[1]
                    if tag then
                        tag:view_only()
                    end
                end,
                {description = "view tag #",group = "tag"})
)


return global_keys