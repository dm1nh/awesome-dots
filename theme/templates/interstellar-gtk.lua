local util = require("theme.util")

local M = {}

M.name = "Interstellar"

M.path = "oomox/colors"
M.filename = "Interstellar"

M.gen = function(schema)
	local sch = util.remove_hashtag_from_schema(schema)
	local template = util.template(
		[[
ACCENT_BG=${accent}
BASE16_GENERATE_DARK=False
BASE16_INVERT_TERMINAL=False
BASE16_MILD_TERMINAL=False
BG=${dark1}
BTN_BG=${dark2}
BTN_FG=${white1}
BTN_OUTLINE_OFFSET=-3
BTN_OUTLINE_WIDTH=1
CARET1_FG=${white1}
CARET2_FG=${white1}
CARET_SIZE=0.0
CINNAMON_OPACITY=1.0
FG=${white1}
GRADIENT=0.0
GTK3_GENERATE_DARK=False
HDR_BG=${dark0}
HDR_BTN_BG=${dark2}
HDR_BTN_FG=${white1}
HDR_FG=${white1}
ICONS_ARCHDROID=${white1}
ICONS_DARK=${dark2}
ICONS_LIGHT=${dark5}
ICONS_LIGHT_FOLDER=${green0}
ICONS_MEDIUM=${green0}
ICONS_NUMIX_STYLE=0
ICONS_STYLE=papirus_icons
ICONS_SYMBOLIC_ACTION=${white1}
ICONS_SYMBOLIC_PANEL=${white1}
MENU_BG=${dark2}
MENU_FG=${white1}
NAME="Interstellar"
OUTLINE_WIDTH=1
ROUNDNESS=4
SEL_BG=${accent}
SEL_FG=${dark1}
SPACING=2
SPOTIFY_PROTO_BG=${dark2}
SPOTIFY_PROTO_FG=${white1}
SPOTIFY_PROTO_SEL=${accent}
SURUPLUS_GRADIENT1=${white1}
SURUPLUS_GRADIENT2=${dark5}
SURUPLUS_GRADIENT_ENABLED=False
TERMINAL_ACCENT_COLOR=${accent}
TERMINAL_BACKGROUND=${dark2}
TERMINAL_BASE_TEMPLATE=basic
TERMINAL_COLOR0=${dark4}
TERMINAL_COLOR1=${red1}
TERMINAL_COLOR10=${green2}
TERMINAL_COLOR11=${yellow2}
TERMINAL_COLOR12=${blue2}
TERMINAL_COLOR13=${magenta2}
TERMINAL_COLOR14=${aqua2}
TERMINAL_COLOR15=${white2}
TERMINAL_COLOR2=${green1}
TERMINAL_COLOR3=${yellow1}
TERMINAL_COLOR4=${blue1}
TERMINAL_COLOR5=${magenta1}
TERMINAL_COLOR6=${aqua1}
TERMINAL_COLOR7=${white1}
TERMINAL_COLOR8=${dark5}
TERMINAL_COLOR9=${red2}
TERMINAL_CURSOR=${white1}
TERMINAL_FOREGROUND=${white1}
TERMINAL_THEME_ACCURACY=128
TERMINAL_THEME_AUTO_BGFG=False
TERMINAL_THEME_EXTEND_PALETTE=False
TERMINAL_THEME_MODE=manual
THEME_STYLE=oomox
TXT_BG=${dark2}
TXT_FG=${white1}
UNITY_DEFAULT_LAUNCHER_STYLE=False
WM_BORDER_FOCUS=${accent}
WM_BORDER_UNFOCUS=${dark2}
    ]],
		sch
	)

	return template
end

return M
