local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")
local gfs = require("gears.filesystem")
local helpers = require("helpers")
local naughty = require("naughty")
local wibox = require("wibox")
local dpi = beautiful.xresources.apply_dpi

return function()
  local widget = wibox.widget({
    widget = wibox.container.background,
    visible = false,
    forced_width = dpi(28),
    forced_height = beautiful.wibar_height,
    {
      widget = wibox.container.place,
      halign = "center",
      valign = "center",
      {
        widget = wibox.widget.textbox,
        font = beautiful.font_icon_default,
        markup = helpers.ui.colorize_text("", beautiful.red1),
      },
    },
  })

  helpers.ui.add_hover_cursor(widget, "hand2")

  widget:buttons(gears.table.join(awful.button({}, 1, nil, function()
    awesome.emit_signal("record::stop")
  end)))

  awesome.connect_signal("record::start", function()
    widget.visible = true
    naughty.notification({
      app_name = "record",
      title = "Recording",
      message = "I am watching you...",
    })
  end)

  awesome.connect_signal("record::stop", function()
    local cmd = gfs.get_configuration_dir() .. "utils/record"
    awful.spawn.easy_async_with_shell(cmd, function()
      widget.visible = false
      naughty.notification({
        app_name = "record",
        title = "Stop recording",
        message = "File saved at ~/Videos.",
      })
    end)
  end)

  return widget
end
