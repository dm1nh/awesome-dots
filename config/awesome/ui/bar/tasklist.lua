local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")
local wibox = require("wibox")
local dpi = beautiful.xresources.apply_dpi

local tasklist_buttons = gears.table.join(
  awful.button({}, 1, function(c)
    c:activate({ context = "tasklist", action = "toggle_minimization" })
  end),
  -- awful.button({}, 3, function()
  --   awful.menu.client_list({ theme = { width = 250 } })
  -- end),
  awful.button({}, 4, function()
    awful.client.focus.byidx(-1)
  end),
  awful.button({}, 5, function()
    awful.client.focus.byidx(1)
  end)
)

return function(s)
  local tasklist = awful.widget.tasklist({
    screen = s,
    filter = awful.widget.tasklist.filter.currenttags,
    layout = { layout = wibox.layout.flex.horizontal, spacing = dpi(2) },
    widget_template = {
      widget = wibox.container.background,
      id = "background_role",
      forced_width = dpi(256),
      {
        widget = wibox.container.margin,
        margins = { left = dpi(12), right = dpi(12) },
        {
          {
            widget = wibox.container.place,
            halign = "center",
            valign = "center",
            {
              widget = wibox.container.constraint,
              forced_width = dpi(16),
              forced_height = dpi(16),
              {
                widget = awful.widget.clienticon,
                id = "client_icon",
              },
            },
          },
          {
            widget = wibox.widget.textbox,
            id = "text_role",
          },
          spacing = dpi(8),
          layout = wibox.layout.fixed.horizontal,
        },
      },
    },
    create_callback = function(self, c)
      self:get_children_by_id("client_icon")[1].client = c
    end,
    buttons = tasklist_buttons,
  })
  return tasklist
end
