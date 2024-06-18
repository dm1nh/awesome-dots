local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")
local wibox = require("wibox")
local dpi = beautiful.xresources.apply_dpi
local helpers = require("helpers")

return function()
  local systray = wibox.widget.systray({
    base_size = beautiful.systray_icon_size,
  })

  local widget = wibox.widget({
    widget = wibox.container.constraint,
    strategy = "max",
    height = beautiful.wibar_height,
    visible = false,
    {
      widget = wibox.container.margin,
      margins = dpi(4),
      systray,
    },
  })

  local enabled = false

  local arrow = wibox.widget({
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
        font = beautiful.font_icon .. " 10",
      },
    },
  })

  local icon = arrow:get_children_by_id("icon_role")[1]

  local update_widget = function()
    if enabled then
      widget:set_visible(true)
      icon.markup = helpers.ui.colorize_text("", beautiful.accent)
    else
      widget:set_visible(false)
      icon.markup = helpers.ui.colorize_text("", beautiful.gray2)
    end
  end

  update_widget()

  local toggle_action = function()
    enabled = not enabled
    update_widget()
  end

  arrow:buttons(gears.table.join(awful.button({}, 1, nil, toggle_action)))

  return wibox.widget({
    layout = wibox.layout.fixed.horizontal,
    arrow,
    widget,
  })
end
