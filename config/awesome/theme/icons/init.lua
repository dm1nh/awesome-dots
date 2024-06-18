local gfs = require("gears.filesystem")
local icons_dir = gfs.get_configuration_dir() .. "theme/icons/"

return {
  layouts = {
    tile = icons_dir .. "layouts/tile.png",
    dwindle = icons_dir .. "layouts/dwindle.png",
    floating = icons_dir .. "layouts/floating.png",
    max = icons_dir .. "layouts/max.png",
  },
}
