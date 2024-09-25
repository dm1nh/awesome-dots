local util = require("theme.util")

local M = {}

M.name = "alacritty"

M.path = "alacritty"
M.filename = "theme.toml"

M.gen = function(schema)
	local template = util.template(
		[[
# ${theme} for Alacritty
# ~/.config/alacritty/theme.toml

[colors.cursor]
cursor = "${white1}"
text = "${dark1}"

[colors.footer_bar]
background = "${white0}"
foreground = "${dark0}"

[colors.hints.end]
background = "${dark0}"
foreground = "${white1}"

[colors.hints.start]
background = "${white1}"
foreground = "${dark0}"

[colors.line_indicator]
background = "None"
foreground = "None"

[colors.bright]
black = "${dark5}"
blue = "${blue2}"
cyan = "${aqua2}"
green = "${green2}"
magenta = "${magenta2}"
red = "${red2}"
white = "${white2}"
yellow = "${yellow2}"

[colors.normal]
black = "${dark5}"
blue = "${blue1}"
cyan = "${aqua1}"
green = "${green1}"
magenta = "${magenta1}"
red = "${red1}"
white = "${white1}"
yellow = "${yellow1}"

[colors.primary]
background = "${dark1}"
bright_foreground = "${white2}"
dim_foreground = "${white0}"
foreground = "${white1}"

[colors.search.focused_match]
background = "${accent}"
foreground = "${dark1}"

[colors.search.matches]
background = "${blue1}"
foreground = "${dark1}"

[colors.selection]
background = "${dark2}"
text = "${white1}"

[colors.vi_mode_cursor]
cursor = "${white1}"
text = "${dark1}"
    ]],
		schema
	)

	return template
end

return M
