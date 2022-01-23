local awful = require('awful')
local naughty = require('naughty')

local utilities = {}

local bright_notification = nil
local volume_notification = nil

utilities.notify_brightness = function()
    awful.spawn.easy_async_with_shell("brightnessctl g", function(stdout)
        local percentage = string.format("%.0f", (tonumber(stdout) / 255) * 100)
        if not bright_notification then
            bright_notification = naughty.notify({
                title = "Brightness",
                icon = os.getenv("HOME") .. "/.config/awesome/theme/sun-solid.svg",
                icon_size= 70,
                opacity= 0.5,
                border_width = 0,
                text = percentage.."%",
                position = "top_middle",
                destroy = function ()
                    bright_notification = nil
                end
            })
        else
            naughty.replace_text(bright_notification, "Brightness", percentage.."%")
        end
    end)
end

utilities.notify_volume = function()
    awful.spawn.easy_async_with_shell("pamixer --get-volume-human", function (stdout)
        local output = string.gsub(stdout, "\n", "")
        local volume = ""
        local icon = ""
        if output == "muted" then
            volume = "Muted"
            icon = "volume-mute-solid"
        else
            volume = string.gsub(output, "%%", "")
            volume = tonumber(volume)
            if volume < 33 then
                icon = "volume-off-solid"
            elseif volume < 66 then
                icon = "volume-down-solid"
            else
                icon = "volume-up-solid"
            end
            volume = volume.."%"
        end

        if volume_notification then
            naughty.destroy(volume_notification)
        end
        volume_notification = naughty.notify({
            title = "Volume",
            icon = os.getenv("HOME") .. "/.config/awesome/theme/"..icon..".svg",
            icon_size= 70,
            opacity= 0.5,
            border_width = 0,
            text = volume,
            position = "top_middle",
            destroy = function ()
                volume_notification = nil
            end
        })
    end)
end

return utilities