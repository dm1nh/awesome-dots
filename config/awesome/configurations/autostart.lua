local apps = require("configurations.apps")
local awful = require("awful")
local gfs = require("gears.filesystem")
local helpers = require("helpers")

local config_dir = gfs.get_configuration_dir()

local function autostart()
  -- monitor
  helpers.run.run_once_grep("xrandr --output HDMI-A-0 --mode 1920x1080 --rate 100")
  helpers.run.run_once_grep("xset r rate 400 60")

  -- compositor
  helpers.run.check_if_running("picom", nil, function()
    awful.spawn("picom -b --config " .. config_dir .. "configurations/picom.conf", false)
  end)

  -- idlehook
  helpers.run.run_once_pgrep(apps.util.idlehook)

  -- polkit agent
  helpers.run.run_once_ps("polkit-kde-authentication-agent-1", "/usr/lib/polkit-kde-authentication-agent-1")

  -- systray applets
  helpers.run.run_once_grep("nm-applet")
  helpers.run.run_once_grep("blueman-applet")

  -- ibus
  helpers.run.run_once_grep("ibus")
end

autostart()
