local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")
local gfs = require("gears.filesystem")
local helpers = require("helpers")
local wibox = require("wibox")
local dpi = beautiful.xresources.apply_dpi
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
      icon.markup = helpers.ui.colorize_text("", beautiful.yellow1)
    else
      icon.markup = helpers.ui.colorize_text("", beautiful.dark4)
    end
  end

  local check_cmd = gfs.get_configuration_dir() .. "utils/util.sh check_redshift"
  local function check_state()
    awful.spawn.easy_async_with_shell(check_cmd, function(_, _, _, exitcode)
      if exitcode ~= 0 then
        enabled = false
      else
        enabled = true
      end

      update_widget()
    end)
  end

  check_state()

  local on_cmd = "redshift -O 5750"
  local off_cmd = "redshift -x"
  local function toggle_action()
    if enabled then
      awful.spawn.easy_async_with_shell(off_cmd, function()
        enabled = false
        update_widget()
        naughty.notification({
          app_name = "nightlight",
          title = "Nightlight: Off",
        })
      end)
    else
      awful.spawn.easy_async_with_shell(on_cmd, function()
        enabled = true
        update_widget()
        naughty.notification({
          app_name = "nightlight",
          title = "Nightlight: On",
        })
      end)
    end
  end

  widget:buttons(gears.table.join(awful.button({}, 1, nil, toggle_action)))

  return widget
end
