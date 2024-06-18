local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")
local xresources = beautiful.xresources
local dpi = xresources.apply_dpi

local M = {}

local FLOATING_RESIZE_AMOUNT = dpi(16)
local TILING_RESIZE_FACTOR = 0.02

-- resize client
function M.resize_client(c, direction)
  if c and c.floating or awful.layout.get(mouse.screen) == awful.layout.suit.floating then
    if direction == "up" then
      c:relative_move(0, 0, 0, -FLOATING_RESIZE_AMOUNT)
    elseif direction == "down" then
      c:relative_move(0, 0, 0, FLOATING_RESIZE_AMOUNT)
    elseif direction == "left" then
      c:relative_move(0, 0, -FLOATING_RESIZE_AMOUNT, 0)
    elseif direction == "right" then
      c:relative_move(0, 0, FLOATING_RESIZE_AMOUNT, 0)
    end
  elseif awful.layout.get(mouse.screen) ~= awful.layout.suit.floating then
    if direction == "up" then
      awful.client.incmwfact(-TILING_RESIZE_FACTOR)
    elseif direction == "down" then
      awful.client.incmwfact(TILING_RESIZE_FACTOR)
    elseif direction == "left" then
      awful.tag.incmwfact(-TILING_RESIZE_FACTOR)
    elseif direction == "right" then
      awful.tag.incmwfact(TILING_RESIZE_FACTOR)
    end
  end
end

-- Move client to screen edge, respecting the screen workarea
function M.move_to_edge(c, direction)
  local workarea = awful.screen.focused().workarea
  if direction == "up" then
    c:geometry({ nil, y = workarea.y + beautiful.useless_gap * 2, nil, nil })
  elseif direction == "down" then
    c:geometry({
      nil,
      y = workarea.height + workarea.y - c:geometry().height - beautiful.useless_gap * 2 - beautiful.border_width * 2,
      nil,
      nil,
    })
  elseif direction == "left" then
    c:geometry({ x = workarea.x + beautiful.useless_gap * 2, nil, nil, nil })
  elseif direction == "right" then
    c:geometry({
      x = workarea.width + workarea.x - c:geometry().width - beautiful.useless_gap * 2 - beautiful.border_width * 2,
      nil,
      nil,
      nil,
    })
  end
end

-- move or swap client
function M.move_client(c, direction)
  if c.floating or (awful.layout.get(mouse.screen) == awful.layout.suit.floating) then
    M.move_to_edge(c, direction)
  elseif awful.layout.get(mouse.screen) == awful.layout.suit.max then
    if direction == "up" or direction == "left" then
      awful.client.swap.byidx(-1, c)
    elseif direction == "down" or direction == "right" then
      awful.client.swap.byidx(1, c)
    end
  else
    awful.client.swap.bydirection(direction, c, nil)
  end
end

-- center a client
function M.centered_client_placement(c)
  return gears.timer.delayed_call(function()
    awful.placement.centered(c, { honor_padding = true, honor_workarea = true })
  end)
end

return M
