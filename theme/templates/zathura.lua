local util = require("theme.util")

local M = {}

M.name = "zathura"

M.path = "zathura"
M.filename = "theme"

M.gen = function(schema)
	local template = util.template(
		[[
set default-fg "${white1}"
set default-bg "${dark1}"

set completion-bg "${dark1}"
set completion-fg "${white1}"
set completion-highlight-bg "${dark2}"
set completion-highlight-fg "${white2}"
set completion-group-bg "${dark1}"
set completion-group-fg "${accent}"

set statusbar-fg "${white1}"
set statusbar-bg "${dark1}"

set notification-bg "${dark1}"
set notification-fg "${white1}"
set notification-error-bg "${dark1}"
set notification-error-fg "${red1}"
set notification-warning-bg "${dark1}"
set notification-warning-fg "${yellow1}"

set inputbar-fg "${white1}"
set inputbar-bg "${dark1}"

set recolor-lightcolor "${dark0}"
set recolor-darkcolor "${white2}"

set index-fg "${white1}"
set index-bg "${dark2}"
set index-active-fg "${white1}"
set index-active-bg "${dark1}"

set render-loading-bg "${dark1}"
set render-loading-fg "${white1}"

set highlight-color "${dark3}"
set highlight-fg "${white1}"
set highlight-active-color "${accent}"]],
		schema
	)

	return template
end

return M
