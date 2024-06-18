-- require("fallback")

local function run()
  pcall(require, "luarocks.loader")
  local gears = require("gears")
  local beautiful = require("beautiful")

  local theme_dir = gears.filesystem.get_configuration_dir() .. "theme/"
  beautiful.init(theme_dir .. "theme.lua")

  require("configurations")

  require("ui")

  --- Enable for lower memory consumption
  ---@diagnostic disable-next-line: param-type-mismatch
  ---@diagnostic disable-next-line: param-type-mismatch
  collectgarbage("incremental", 150, 1000, 0)
  gears.timer.start_new(10, function()
    -- set a step size
    collectgarbage("step", 20000)
    return true
  end)
end

run()
