local awful = require("awful")
require("awful.autofocus")
local beautiful = require("beautiful")
local gears = require("gears")
local gfs = require("gears.filesystem")
local helpers = require("helpers")

client.connect_signal("request::manage", function(c)
  c.shape = helpers.ui.rrect(beautiful.border_radius)
  --- Set the windows at the slave,
  if not awesome.startup then
    awful.client.setslave(c)
  end

  --- Prevent clients from being unreachable after screen count changes.
  if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
    awful.placement.no_offscreen(c)
  end
end)

--- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
  c:emit_signal("request::activate", "mouse_enter", { raise = false })
end)

--- Wallpapers
awful.screen.connect_for_each_screen(function(s)
  local random_index = math.floor(math.random() * 11)
  ---@diagnostic disable-next-line: param-type-mismatch
  local wallpaper =
    ---@diagnostic disable-next-line: param-type-mismatch
    gears.surface.load_uncached(gfs.get_configuration_dir() .. "theme/assets/wallpaper" .. random_index .. ".png")

  if type(wallpaper) == "function" then
    wallpaper = wallpaper(s)
  end

  gears.wallpaper.maximized(wallpaper, s, false, nil)
end)

screen.connect_signal("request::desktop_decoration", function(s)
  awful.tag({ "1", "2", "3", "4", "5", "6" }, s, awful.layout.layouts[1])
end)

-- Unity repaint fix
local last_focus = nil
local unity_force_repaint = true
client.connect_signal("focus", function(c)
  if not c then
    return
  end -- that can happen :/

  -- This is needed to have Unity on one screen and some utility panels on another
  -- without constantly repainting whenever the user switches back and forth
  if
    not unity_force_repaint
    and last_focus
    and last_focus.valid
    and last_focus.tag == c.tag
    and awful.rules.match(last_focus, { class = "Unity" })
  then
    last_focus = c
    return
  end
  last_focus = c
  unity_force_repaint = false

  if not awful.rules.match(c, { class = "Unity" }) then
    return
  end
  if awful.rules.match(c, { rule_any = { type = { "dialog", "popup", "popup_menu" } } }) then
    return
  end -- Ignore these types of windows
  if awful.rules.match(c, { name = "Select" }) then
    return
  end

  -- The workaround
  -- note: gears.timer.delayed_call doesn't not seem to work for this
  c.fullscreen = false
  gears.timer.start_new(1 / 60, function() -- 0 doesn't always work in every case
    c.fullscreen = true
  end)
end)

tag.connect_signal("property::selected", function()
  unity_force_repaint = true
end)
