local gfs = require("gears.filesystem")
local config_dir = gfs.get_configuration_dir()
local utils_dir = config_dir .. "utils/"

return {
  -- default applications
  default = {
    term = "alacritty",
    fterm = "alacritty --title fterm --class fterm",
    calculator = "alacritty --title calc --class calc -e calc",
    editor = "alacritty -e nvim",
    web_browser = "firefox-developer-edition",
    file_browser = "thunar",
    network_manager = "nm-connection-editor",
    bluetooth_manager = "blueman-manager",
    sound = "pavucontrol",
    aseprite = "aseprite",
    godot = "godot --single-window",
    blender = "blender",
  },
  dmenu = {
    launcher = utils_dir .. "dmenu.sh launcher",
    quit = utils_dir .. "dmenu.sh quit",
    screenshot = utils_dir .. "dmenu.sh screenshot",
    record = utils_dir .. "dmenu.sh record",
    colorpicker = utils_dir .. "dmenu.sh colorpicker",
    docs = utils_dir .. "dmenu.sh docs",
    clients = utils_dir .. "dmenu.sh clients",
  },
  util = {
    idlehook = utils_dir .. "util.sh idle",
  },
}
