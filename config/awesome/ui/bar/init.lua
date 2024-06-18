local awful = require("awful")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local wibox = require("wibox")

-- components
local bluetooth = require("ui.bar.bluetooth")
local clock = require("ui.bar.clock")
local dnd = require("ui.bar.dnd")
local idle_inhibitor = require("ui.bar.idle-inhibitor")
local layoutbox = require("ui.bar.layoutbox")
local nightlight = require("ui.bar.nightlight")
local record = require("ui.bar.record")
local systray = require("ui.bar.systray")
local taglist = require("ui.bar.taglist")
local tasklist = require("ui.bar.tasklist")
local volume = require("ui.bar.volume")

return function(s)
  -- Main bar
  s.bar = awful.popup({
    screen = s,
    type = "dock",
    minimum_height = beautiful.wibar_height,
    maximum_height = beautiful.wibar_height,
    minimum_width = s.geometry.width,
    maximum_width = s.geometry.width,
    placement = function(c)
      awful.placement.bottom(c)
    end,
    widget = {
      widget = wibox.container.background,
      bg = beautiful.ink_dark,
      {
        widget = wibox.container.margin,
        margins = { left = dpi(8), right = dpi(8) },
        {
          widget = wibox.layout.align.horizontal,
          {
            taglist(s),
            tasklist(s),
            spacing = beautiful.wibar_height,
            layout = wibox.layout.fixed.horizontal,
          },
          nil,
          {
            systray(),
            record(),
            volume(),
            bluetooth(),
            idle_inhibitor(),
            nightlight(),
            dnd(),
            clock(),
            layoutbox(s),
            spacing = dpi(2),
            layout = wibox.layout.fixed.horizontal,
          },
        },
      },
    },
  })

  s.bar:struts({
    bottom = s.bar.maximum_height,
  })
end
