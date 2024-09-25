local templates = {
	"alacritty",
	"awesome",
	"btop",
	"fish",
	"imv",
	"interstellar-gtk",
	"interstellar-darker-gtk",
	"rofi",
	"sugar-candy",
	"zathura",
}

local modules = {}

for _, t in ipairs(templates) do
	modules[t] = require("theme.templates." .. t)
end

return modules
