local util = require("theme.util")

local M = {}

M.name = "zathura"

M.path = "zathura"
M.filename = "theme"

M.gen = function(schema)
	local template = util.template(
		[[
set default-fg "${white1}"
set default-bg "${ink1}"

set completion-bg "${ink1}"
set completion-fg "${white1}"
set completion-highlight-bg "${ink2}"
set completion-highlight-fg "${white2}"
set completion-group-bg "${ink1}"
set completion-group-fg "${accent}"

set statusbar-fg "${white1}"
set statusbar-bg "${ink1}"

set notification-bg "${ink1}"
set notification-fg "${white1}"
set notification-error-bg "${ink1}"
set notification-error-fg "${red1}"
set notification-warning-bg "${ink1}"
set notification-warning-fg "${yellow1}"

set inputbar-fg "${white1}"
set inputbar-bg "${ink1}"

set recolor-lightcolor "${ink0}"
set recolor-darkcolor "${white2}"

set index-fg "${white1}"
set index-bg "${ink2}"
set index-active-fg "${white1}"
set index-active-bg "${ink1}"

set render-loading-bg "${ink1}"
set render-loading-fg "${white1}"

set highlight-color "${ink3}"
set highlight-fg "${white1}"
set highlight-active-color "${accent}"]],
		schema
	)

	return template
end

return M
