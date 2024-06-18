local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")
local wibox = require("wibox")
local dpi = beautiful.xresources.apply_dpi
local helpers = require("helpers")

local MOD = "Mod4"

-- Tag list
local taglist_buttons = gears.table.join(
  awful.button({}, 1, function(t)
    t:view_only()
  end),
  awful.button({ MOD }, 1, function(t)
    if client.focus then
      client.focus:move_to_tag(t)
    end
  end),
  awful.button({}, 3, awful.tag.viewtoggle),
  awful.button({ MOD }, 3, function(t)
    if client.focus then
      client.focus:toggle_tag(t)
    end
  end),
  awful.button({}, 4, function(t)
    awful.tag.viewnext(t.screen)
  end),
  awful.button({}, 5, function(t)
    awful.tag.viewprev(t.screen)
  end)
)

return function(s)
  local taglist = awful.widget.taglist({
    screen = s,
    filter = awful.widget.taglist.filter.all,
    layout = { layout = wibox.layout.fixed.horizontal, spacing = dpi(6) },
    widget_template = {
      widget = wibox.container.margin,
      forced_width = beautiful.wibar_height,
      forced_height = beautiful.wibar_height,
      create_callback = function(self, c3, _)
        self.indicator = wibox.widget({
          widget = wibox.container.place,
          halign = "center",
          valign = "center",
          {
            widget = wibox.container.background,
            forced_height = dpi(6),
            forced_width = dpi(32),
            shape = helpers.ui.rrect(dpi(2)),
          },
        })

        self:set_widget(self.indicator)

        if c3.selected then -- current focused tag
          self.widget.children[1].bg = beautiful.accent
        elseif #c3:clients() > 0 then -- occupied tag
          self.widget.children[1].bg = beautiful.blue1
        else -- empty and no-focused tag
          self.widget.children[1].bg = beautiful.ink5
        end
      end,
      update_callback = function(self, c3, _)
        if c3.selected then -- current focused tag
          self.widget.children[1].bg = beautiful.accent
        elseif #c3:clients() > 0 then -- occupied tag
          self.widget.children[1].bg = beautiful.blue1
        else -- empty and no-focused tag
          self.widget.children[1].bg = beautiful.ink5
        end
      end,
    },
    buttons = taglist_buttons,
  })

  return wibox.widget({
    widget = wibox.container.place,
    taglist,
  })
end
