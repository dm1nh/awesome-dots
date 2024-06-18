local awful = require("awful")
local bar = require("ui.bar")

require("ui.notifications")
require("ui.lockscreen").init()

awful.screen.connect_for_each_screen(function(s)
  bar(s)
end)
