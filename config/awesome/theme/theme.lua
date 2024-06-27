local gears = require("gears")
local gfs = gears.filesystem
local themes_path = gfs.get_themes_dir()
local theme = dofile(themes_path .. "default/theme.lua")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local helpers = require("helpers")
local icons = require("theme.icons")
local palette = require("theme.palette")

-- fonts
theme.font_sans = "Cosmos Nerd Font"
theme.font = theme.font_sans .. " Regular 12"
theme.font_icon = "Material Icons Round"
theme.font_icon_default = theme.font_icon .. " 14"

-- colors
theme.transparent = "#00000000"
theme = gears.table.crush(theme, palette)

-- black
theme.color0 = theme.gray1
theme.color8 = theme.gray2
-- red
theme.color1 = theme.red1
theme.color9 = theme.red2
-- green
theme.color2 = theme.green1
theme.color10 = theme.green2
-- yellow
theme.color3 = theme.yellow1
theme.color11 = theme.yellow2
-- blue
theme.color4 = theme.blue1
theme.color12 = theme.blue2
-- magenta
theme.color5 = theme.magenta1
theme.color13 = theme.magenta2
-- cyan
theme.color6 = theme.aqua1
theme.color14 = theme.aqua2
-- white
theme.color7 = theme.white1
theme.color15 = theme.white2

-- layout icons
theme.layout_tile = icons.layouts.tile
theme.layout_dwindle = icons.layouts.dwindle
theme.layout_floating = icons.layouts.floating
theme.layout_max = icons.layouts.max

theme.master_width_factor = 0.5275
theme.master_count = 1
theme.column_count = 1

-- wibar
theme.wibar_height = dpi(26)

-- gaps
theme.useless_gap = 0

--- systray
theme.systray_icon_size = dpi(10)
theme.systray_icon_spacing = dpi(16)
theme.bg_systray = theme.ink_dark

-- Tooltips
theme.tooltip_bg = theme.ink1
theme.tooltip_fg = theme.white1
theme.tooltip_shape = helpers.ui.rrect(dpi(2))
theme.tooltip_gaps = dpi(4)
theme.tooltip_opacity = 0.8

-- Borders
theme.border_width = 1
theme.border_radius = 6
theme.border_color_floating_active = theme.blue1
theme.border_color_floating_normal = theme.ink4
theme.border_color_urgent = theme.red1
theme.border_color_active = theme.accent
theme.border_color_normal = theme.transparent

-- Opacity, enabled if xcompmgr is installed
-- theme.opacity_normal = 0.8
-- theme.opacity_active = 1.0

-- Notifications
theme.notification_spacing = dpi(4)
theme.notification_bg = theme.ink_dark
theme.notification_border_width = 0
theme.notification_border_color = theme.transparent

-- Tasklist
theme.tasklist_plain_task_name = true
theme.tasklist_fg_normal = theme.white2
theme.tasklist_bg_normal = theme.ink0
theme.tasklist_fg_focus = theme.accent
theme.tasklist_bg_focus = theme.ink1
theme.tasklist_fg_urgent = theme.ink1
theme.tasklist_bg_urgent = theme.red1
theme.tasklist_fg_minimize = theme.ink1
theme.tasklist_bg_minimize = theme.blue1
theme.tasklist_shape = helpers.ui.rrect(dpi(2))

-- Swallowing
theme.dont_swallow_classname_list = {
  "firefox",
  "firefox-developer-edition",
  "gimp",
  "Google-chrome",
}

return theme
