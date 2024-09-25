local util = require("theme.util")

local M = {}

M.name = "imv"

M.path = "imv"
M.filename = "config"

M.gen = function(schema)
	local template = util.template(
		[[
# ${theme} for imv
# ~/.config/imv/config

# styling
[options]
background = ${dark1}
fullscreen = false
overlay = true
overlay_text_color = ${white1}
overlay_background_color = ${dark2}
overlay_background_alpha = ff
overlay_font = Astro Nerd Font Medium:11
overlay_position_bottom = false

# bindings
[binds]
j = next
k = prev]],
		schema
	)

	return template
end

return M
