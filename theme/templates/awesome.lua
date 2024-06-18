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
  ink_dark = "${ink_dark}",
  ink0 = "${ink0}",
  ink1 = "${ink1}",
  ink2 = "${ink2}",
  ink3 = "${ink3}",
  ink4 = "${ink4}",
  ink5 = "${ink5}",
  ink6 = "${ink6}",
  -- foregrounds
  white0 = "${white0}",
  white1 = "${white1}",
  white2 = "${white2}",
  white3 = "${white3}",
  white4 = "${white4}",
  white5 = "${white5}",
  -- comments and gutters
  gray0 = "${gray0}",
  gray1 = "${gray1}",
  gray2 = "${gray2}",
  -- red
  red_dark = "${red_dark}",
  red0 = "${red0}",
  red1 = "${red1}",
  red2 = "${red2}",
  red3 = "${red3}",
  red4 = "${red4}",
  -- amber
  amber_dark = "${amber_dark}",
  amber0 = "${amber0}",
  amber1 = "${amber1}",
  amber2 = "${amber2}",
  amber3 = "${amber3}",
  amber4 = "${amber4}",
  -- yellow
  yellow_dark = "${yellow_dark}",
  yellow0 = "${yellow0}",
  yellow1 = "${yellow1}",
  yellow2 = "${yellow2}",
  yellow3 = "${yellow3}",
  yellow4 = "${yellow4}",
  -- green
  green_dark = "${green_dark}",
  green0 = "${green0}",
  green1 = "${green1}",
  green2 = "${green2}",
  green3 = "${green3}",
  green4 = "${green4}",
  -- aqua
  aqua_dark = "${aqua_dark}",
  aqua0 = "${aqua0}",
  aqua1 = "${aqua1}",
  aqua2 = "${aqua2}",
  aqua3 = "${aqua3}",
  aqua4 = "${aqua4}",
  -- blue
  blue_dark = "${blue_dark}",
  blue0 = "${blue0}",
  blue1 = "${blue1}",
  blue2 = "${blue2}",
  blue3 = "${blue3}",
  blue4 = "${blue4}",
  -- violet
  violet_dark = "${violet_dark}",
  violet0 = "${violet0}",
  violet1 = "${violet1}",
  violet2 = "${violet2}",
  violet3 = "${violet3}",
  violet4 = "${violet4}",
  -- magenta
  magenta_dark = "${magenta_dark}",
  magenta0 = "${magenta0}",
  magenta1 = "${magenta1}",
  magenta2 = "${magenta2}",
  magenta3 = "${magenta3}",
  magenta4 = "${magenta4}",
}
    ]],
		schema
	)

	return template
end

return M
