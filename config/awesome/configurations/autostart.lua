local apps = require("configurations.apps")
local helpers = require("helpers")

local function autostart()
  -- monitor
  helpers.run.run_once_grep("xrandr --output HDMI-A-0 --mode 1920x1080 --rate 100")
  helpers.run.run_once_grep("xset r rate 400 60")

  -- idlehook
  helpers.run.run_once_pgrep(apps.util.idlehook)

  -- polkit agent
  helpers.run.run_once_ps("polkit-kde-authentication-agent-1", "/usr/lib/polkit-kde-authentication-agent-1")

  -- stuff
  helpers.run.run_once_grep("nm-applet")
end

autostart()
