local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")
local helpers = require("helpers")
local wibox = require("wibox")

local dpi = beautiful.xresources.apply_dpi

return function(s)
  local layoutbox_buttons = gears.table.join(
    --- Left click
    awful.button({}, 1, function()
      awful.layout.inc(1)
    end),

    --- Right click
    awful.button({}, 3, function()
      awful.layout.inc(-1)
    end),

    --- Scrolling
    awful.button({}, 4, function()
      awful.layout.inc(-1)
    end),
    awful.button({}, 5, function()
      awful.layout.inc(1)
    end)
  )

  local layoutbox = awful.widget.layoutbox({
    screen = s,
    buttons = layoutbox_buttons,
  })

  local widget = wibox.widget({
    widget = wibox.container.constraint,
    forced_width = dpi(28),
    forced_height = beautiful.wibar_height,
    {
      widget = wibox.container.place,
      halign = "center",
      valign = "center",
      {
        widget = wibox.container.margin,
        top = dpi(5),
        bottom = dpi(5),
        layoutbox,
      },
    },
  })

  helpers.ui.add_hover_cursor(widget, "hand2")

  return widget
end
