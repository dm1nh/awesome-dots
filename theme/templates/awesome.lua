local util = require("theme.util")

local M = {}

M.name = "awesome"

M.path = "awesome/theme"
M.filename = "palette.lua"

M.gen = function(schema)
	local template = util.template(
		[[
return {
  accent = "${accent}",
  -- backgrounds
  dark = "${dark}",
  dark0 = "${dark0}",
  dark1 = "${dark1}",
  dark2 = "${dark2}",
  dark3 = "${dark3}",
  dark4 = "${dark4}",
  dark5 = "${dark5}",

  -- foregrounds
  white = "${white}",
  white0 = "${white0}",
  white1 = "${white1}",
  white2 = "${white2}",

  -- red
  red = "${red_dark}",
  red0 = "${red0}",
  red1 = "${red1}",
  red2 = "${red2}",

  -- amber
  amber = "${amber}",
  amber0 = "${amber0}",
  amber1 = "${amber1}",
  amber2 = "${amber2}",

  -- yellow
  yellow = "${yellow}",
  yellow0 = "${yellow0}",
  yellow1 = "${yellow1}",
  yellow2 = "${yellow2}",

  -- green
  green = "${green}",
  green0 = "${green0}",
  green1 = "${green1}",
  green2 = "${green2}",

  -- aqua
  aqua = "${aqua}",
  aqua0 = "${aqua0}",
  aqua1 = "${aqua1}",
  aqua2 = "${aqua2}",

  -- blue
  blue = "${blue}",
  blue0 = "${blue0}",
  blue1 = "${blue1}",
  blue2 = "${blue2}",

  -- violet
  violet = "${violet}",
  violet0 = "${violet0}",
  violet1 = "${violet1}",
  violet2 = "${violet2}",

  -- magenta
  magenta = "${magenta}",
  magenta0 = "${magenta0}",
  magenta1 = "${magenta1}",
  magenta2 = "${magenta2}",
}
    ]],
		schema
	)

	return template
end

return M
