local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local gs = gears.shape

local M = {}

function M.colorize_text(txt, clr)
  return "<span foreground='" .. clr .. "'>" .. txt .. "</span>"
end

function M.add_hover_cursor(w, hover_cursor)
  local default_cursor = "left_ptr"

  w:connect_signal("mouse::enter", function()
    local widget = mouse.current_wibox
    if widget then
      widget.cursor = hover_cursor
    end
  end)
  w:connect_signal("mouse::leave", function()
    local widget = mouse.current_wibox
    if widget then
      widget.cursor = default_cursor
    end
  end)
end

function M.rrect(radius)
  return function(cr, width, height)
    gs.rounded_rect(cr, width, height, radius)
  end
end

function M.screen_mask(s, bg)
  local mask = wibox({
    visible = false,
    ontop = true,
    type = "splash",
    screen = s,
  })
  awful.placement.maximize(mask)
  mask.bg = bg
  return mask
end

function M.vertical_pad(height)
  return wibox.widget({
    forced_height = height,
    layout = wibox.layout.fixed.vertical,
  })
end

function M.horizontal_pad(width)
  return wibox.widget({
    forced_width = width,
    layout = wibox.layout.fixed.horizontal,
  })
end

return M
