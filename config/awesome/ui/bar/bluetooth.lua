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

  local widget = wibox.widget({
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

  helpers.ui.add_hover_cursor(widget, "hand2")

  local icon = widget:get_children_by_id("icon_role")[1]

  local function update_widget()
    if enabled then
      icon.markup = helpers.ui.colorize_text("", beautiful.blue1)
    else
      icon.markup = helpers.ui.colorize_text("", beautiful.gray1)
    end
  end

  local check_cmd = "rfkill list bluetooth"
  local function check_state()
    awful.spawn.easy_async_with_shell(check_cmd, function(stdout)
      if stdout:match("Soft blocked: yes") then
        enabled = false
      else
        enabled = true
      end

      update_widget()
    end)
  end

  check_state()

  local on_cmd = [[
    rfkill unblock bluetooth
    bluetoothctl power on
  ]]
  local off_cmd = [[
    bluetoothctl power off
    rfkill block bluetooth
  ]]
  local function toggle_action()
    if enabled then
      awful.spawn.easy_async_with_shell(off_cmd, function()
        enabled = false
        update_widget()
        naughty.notification({
          app_name = "bluetooth",
          title = "Bluetooth: Off",
        })
      end)
    else
      awful.spawn.easy_async_with_shell(on_cmd, function()
        enabled = true
        update_widget()
        naughty.notification({
          app_name = "bluetooth",
          title = "Bluetooth: On",
        })
      end)
    end
  end

  widget:buttons(gears.table.join(
    awful.button({}, 1, nil, toggle_action),
    awful.button({}, 3, function()
      awful.spawn(apps.default.bluetooth_manager)
    end)
  ))

  awful.widget.watch(check_cmd, 30, function()
    check_state()
    collectgarbage("collect")
  end)

  return widget
end
