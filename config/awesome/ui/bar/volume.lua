local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")
local helpers = require("helpers")
local wibox = require("wibox")
local dpi = beautiful.xresources.apply_dpi
local apps = require("configurations.apps")
local naughty = require("naughty")

return function()
  local enabled = false
  local value = 0

  local volume = wibox.widget({
    widget = wibox.container.background,
    forced_width = dpi(28),
    forced_height = beautiful.wibar_height,
    {
      widget = wibox.container.place,
      halign = "center",
      valign = "center",
      {
        widget = wibox.widget.textbox,
        id = "icon_role",
        font = beautiful.font_icon_default,
      },
    },
  })

  local t = awful.tooltip({
    objects = { volume },
  })

  helpers.ui.add_hover_cursor(volume, "hand2")

  local icon = volume:get_children_by_id("icon_role")[1]

  local function update_widget()
    if enabled then
      awful.spawn.easy_async_with_shell([[pamixer --get-volume]], function(stdout)
        value = tonumber(stdout) or 0

        if value >= 50 then
          icon.markup = helpers.ui.colorize_text("", beautiful.aqua1)
        elseif value < 50 and value > 0 then
          icon.markup = helpers.ui.colorize_text("", beautiful.aqua1)
        else
          icon.markup = helpers.ui.colorize_text("", beautiful.aqua1)
        end

        t.text = "Volume: " .. value .. "%"
      end)
    else
      icon.markup = helpers.ui.colorize_text("", beautiful.dark4)
      t.text = "Awkward silence"
    end
  end

  local check_cmd = [[pamixer --get-mute]]
  local function check_state()
    awful.spawn.easy_async_with_shell(check_cmd, function(stdout)
      if stdout:match("false") then
        enabled = true
      else
        enabled = false
      end

      update_widget()
    end)
  end

  check_state()

  local function toggle_action()
    awful.spawn.easy_async_with_shell([[pamixer --toggle-mute]], function()
      enabled = not enabled
      update_widget()
      naughty.notification({
        app_name = "volume",
        title = "Sound: " .. (enabled and "On" or "Off"),
      })
    end)
  end

  volume:buttons(gears.table.join(
    awful.button({}, 1, nil, toggle_action),
    awful.button({}, 3, nil, function()
      awful.spawn(apps.default.sound, false)
    end),
    awful.button({}, 4, nil, function()
      awful.spawn.easy_async_with_shell([[pamixer --set-volume ]] .. value + 4, function()
        update_widget()
      end)
    end),
    awful.button({}, 5, nil, function()
      awful.spawn.easy_async_with_shell([[pamixer --set-volume ]] .. value - 4, function()
        update_widget()
      end)
    end)
  ))

  awful.widget.watch(check_cmd, 30, function()
    check_state()
    collectgarbage("collect")
  end)

  return volume
end
