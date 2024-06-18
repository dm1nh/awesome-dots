local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")
local helpers = require("helpers")
local naughty = require("naughty")
local wibox = require("wibox")
local dpi = beautiful.xresources.apply_dpi

local utils_dir = gears.filesystem.get_configuration_dir() .. "utils/"

_G.dnd_enabled = false

return function()
  local widget = wibox.widget({
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
        font = beautiful.font_icon_default,
      },
    },
  })

  helpers.ui.add_hover_cursor(widget, "hand2")

  local icon = widget:get_children_by_id("icon_role")[1]

  local function update_widget()
    if not _G.dnd_enabled then
      if #naughty.active > 0 then
        icon.markup = helpers.ui.colorize_text("", beautiful.amber0)
      else
        icon.markup = helpers.ui.colorize_text("", beautiful.amber1)
      end
    else
      icon.markup = helpers.ui.colorize_text("", beautiful.gray1)
    end
  end

  local check_cmd = "cat " .. utils_dir .. "dnd_enabled"
  local function check_state()
    awful.spawn.easy_async_with_shell(check_cmd, function(stdout)
      if stdout:match("true") then
        _G.dnd_enabled = true
      elseif stdout:match("false") then
        _G.dnd_enabled = false
      else
        _G.dnd_enabled = false
        awful.spawn.with_shell("echo false >" .. utils_dir .. "dnd_enabled")
      end

      update_widget()
    end)
  end

  check_state()

  local function toggle_action()
    if _G.dnd_enabled then
      _G.dnd_enabled = false
    else
      _G.dnd_enabled = true
    end
    awful.spawn.easy_async_with_shell(
      "echo " .. tostring(_G.dnd_enabled) .. " >" .. utils_dir .. "dnd_enabled",
      function()
        update_widget()
      end
    )
  end

  widget:buttons(gears.table.join(awful.button({}, 1, nil, toggle_action)))

  return widget
end
