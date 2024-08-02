local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")
local helpers = require("helpers")
local menubar = require("menubar")
local naughty = require("naughty")
local wibox = require("wibox")
local dpi = beautiful.xresources.apply_dpi

-- global configs
naughty.persistence_enabled = true
naughty.config.defaults.ontop = true
naughty.config.defaults.timeout = 6
naughty.config.defaults.title = "System notification"
naughty.config.defaults.position = "bottom_right"

local function get_oldest_notification()
  for _, n in ipairs(naughty.active) do
    if n and n.timeout > 0 then
      return n
    end
  end

  -- fallback
  return naughty.active[1]
end

-- handle icon
naughty.connect_signal("request::icon", function(n, context, hints)
  if context ~= "app_icon" then
    return
  end

  -- xdg icons
  local path = menubar.utils.lookup_icon(hints.app_icon) or menubar.utils.lookup_icon(hints.app_icon:lower())

  if path then
    n.icon = path
  end
end)

-- use xdg icons
naughty.connect_signal("request::action_icon", function(a, _, hints)
  a.icon = menubar.utils.lookup_icon(hints.id)
end)

naughty.connect_signal("request::display", function(n)
  local app_icons = {
    ["screenshot"] = { "", beautiful.yellow1 },
    ["colorpicker"] = { "", beautiful.aqua1 },
    ["record"] = { "", beautiful.magenta1 },
    ["nightlight"] = { "", beautiful.yellow1 },
    ["bluetooth"] = { "", beautiful.blue1 },
    ["volume"] = { "", beautiful.aqua1 },
    ["idle inhibitor"] = { "", beautiful.violet1 },
  }

  local app_icon = nil
  if app_icons[string.lower(n.app_name)] then
    app_icon = app_icons[string.lower(n.app_name)]
  else
    app_icon = { "", beautiful.accent }
  end

  local app_icon_n = wibox.widget({
    widget = wibox.widget.textbox,
    font = beautiful.font_icon .. " 24",
    markup = helpers.ui.colorize_text(app_icon[1], app_icon[2]),
  })

  -- Icon widget
  local icon = wibox.widget({
    layout = wibox.layout.stack,
    -- app icon as image
    {
      widget = wibox.container.constraint,
      height = dpi(48),
      width = dpi(48),
      strategy = "exact",
      {
        widget = wibox.container.background,
        shape = gears.shape.circle,
        {
          widget = wibox.widget.imagebox,
          halign = "center",
          valign = "center",
          clip_shape = gears.shape.circle,
          resize = true,
          image = n.icon,
        },
      },
    },
    -- app icon as text
    {
      widget = wibox.container.place,
      halign = "center",
      valign = "center",
      app_icon_n,
    },
  })

  -- App name widget
  local app_name = wibox.widget({
    widget = wibox.widget.textbox,
    font = beautiful.font,
    markup = helpers.ui.colorize_text(n.app_name:gsub("^%l", string.upper) or "System", beautiful.white1),
  })

  -- Dismiss button widget
  local dismiss = wibox.widget({
    widget = wibox.container.background,
    bg = beautiful.red1,
    shape = gears.shape.circle,
    forced_width = dpi(16),
    forced_height = dpi(16),
    {
      widget = wibox.container.place,
      halign = "center",
      valign = "center",
      {
        widget = wibox.widget.textbox,
        font = beautiful.font_icon .. " 11",
        markup = helpers.ui.colorize_text("", beautiful.ink0),
      },
    },
  })
  dismiss:buttons(gears.table.join(awful.button({}, 1, function()
    n:destroy(naughty.notification_closed_reason.dismissed_by_user)
  end)))

  -- title widget
  local title = wibox.widget({
    widget = wibox.widget.textbox,
    font = beautiful.font_sans .. " Bold 11",
    markup = "<b>" .. n.title .. "</b>",
  })

  -- message widget
  local message = wibox.widget({
    widget = wibox.container.scroll.horizontal,
    step_function = wibox.container.scroll.step_functions.waiting_nonlinear_back_and_forth,
    fps = 60,
    speed = 75,
    {
      widget = wibox.widget.textbox,
      font = beautiful.font,
      markup = helpers.ui.colorize_text(n.message, beautiful.white2),
    },
  })

  -- actions
  local actions = wibox.widget({
    notification = n,
    base_layout = wibox.widget({
      layout = wibox.layout.flex.horizontal,
      spacing = dpi(4),
    }),
    widget_template = {
      widget = wibox.container.background,
      forced_height = dpi(28),
      bg = beautiful.ink2,
      shape = helpers.ui.rrect(beautiful.border_radius),
      {
        widget = wibox.container.place,
        {
          widget = wibox.container.margin,
          margins = { left = dpi(8), right = dpi(8) },
          {
            widget = wibox.widget.textbox,
            id = "text_role",
            font = beautiful.font,
          },
        },
      },
    },
    style = {
      underline_normal = false,
      underline_selected = true,
    },
    widget = naughty.list.actions,
  })

  local widget = naughty.layout.box({
    notification = n,
    type = "notification",
    cursor = "hand2",
    maximum_width = dpi(360),
    minimum_width = dpi(360),
    maximum_height = dpi(120),
    bg = beautiful.transparent,
    widget_template = {
      widget = wibox.container.background,
      bg = beautiful.notification_bg,
      shape = helpers.ui.rrect(beautiful.border_radius),
      {
        layout = wibox.layout.fixed.vertical,
        {
          {
            {
              layout = wibox.layout.align.horizontal,
              app_name,
              nil,
              dismiss,
            },
            margins = { top = dpi(4), bottom = dpi(4), left = dpi(8), right = dpi(4) },
            widget = wibox.container.margin,
          },
          bg = beautiful.ink3,
          widget = wibox.container.background,
        },
        {
          {
            layout = wibox.layout.fixed.vertical,
            {
              layout = wibox.layout.fixed.horizontal,
              spacing = dpi(10),
              icon,
              {
                expand = "none",
                layout = wibox.layout.align.vertical,
                nil,
                {
                  layout = wibox.layout.fixed.vertical,
                  title,
                  message,
                },
                nil,
              },
            },
            {
              nil,
              {
                actions,
                shape = helpers.ui.rrect(beautiful.border_radius / 2),
                widget = wibox.container.background,
              },
              visible = n.actions and #n.actions > 0,
              layout = wibox.layout.fixed.vertical,
            },
          },
          margins = dpi(8),
          widget = wibox.container.margin,
        },
      },
    },
  })

  widget.buttons = {}

  widget:connect_signal("mouse::enter", function()
    n:set_timeout(999)
  end)

  local notification_height = widget.height + beautiful.notification_spacing
  local total_height = #naughty.active * notification_height

  if total_height > n.screen.workarea.height then
    get_oldest_notification():destroy(naughty.notification_closed_reason.too_many_on_screen)
  end

  if _G.dnd_enabled then
    naughty.destroy_all_notifications(nil, 1)
  end

  -- -- uncommnet this to play sound
  -- if not _G.dnd_enabled then
  --   awful.spawn("canberra-gtk-play -i bell", false)
  -- end
end)

require("ui.notifications.error")
