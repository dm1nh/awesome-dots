local beautiful = require("beautiful")
local wibox = require("wibox")
local dpi = beautiful.xresources.apply_dpi

return function()
  local widget = wibox.widget({
    widget = wibox.container.margin,
    left = dpi(6),
    right = dpi(6),
    {
      widget = wibox.widget.textclock,
      format = "%H:%M",
      font = beautiful.font_sans .. " Bold 14",
    },
  })

  return widget
end
