local util = require("theme.util")

local M = {}

M.name = "btop"

M.path = "btop/themes"
M.filename = "theme.theme"

M.gen = function(schema)
	local template = util.template(
		[[
# ${theme} colorscheme for btop
# ~/.config/btop/themes/theme.theme

# All graphs and meters can be gradients
# For single color graphs leave "mid" and "end" variable empty.
# Use "start" and "end" variables for two color gradient
# Use "start", "mid" and "end" for three color gradient

# Main background, empty for terminal default, need to be empty if you want transparent background
theme[main_bg]="${dark1}"

# Main text color
theme[main_fg]="${white1}"

# Title color for boxes
theme[title]="${white1}"

# Highlight color for keyboard shortcuts
theme[hi_fg]="${red1}"

# Background color of selected items
theme[selected_bg]="${dark3}"

# Foreground color of selected items
theme[selected_fg]="${yellow1}"

# Color of inactive/disabled text
theme[inactive_fg]="${white2}"

# Color of text appearing on top of graphs, i.e uptime and current network graph scaling
theme[graph_text]="${white1}"

# Misc colors for processes box including mini cpu graphs, details memory graph and details status text
theme[proc_misc]="${accent}"

# Cpu box outline color
theme[cpu_box]=${dark3}""

# Memory/disks box outline color
theme[mem_box]="${dark3}"

# Net up/down box outline color
theme[net_box]="${dark3}"

# Processes box outline color
theme[proc_box]="${dark3}"

# Box divider line and small boxes line color
theme[div_line]="${dark3}"

# Temperature graph colors
theme[temp_start]="${green1}"
theme[temp_mid]="${yellow1}"
theme[temp_end]="${red1}"

# CPU graph colors
theme[cpu_start]="${green1}"
theme[cpu_mid]="${yellow1}"
theme[cpu_end]="${red1}"

# Mem/Disk free meter
theme[free_start]="${green1}"
theme[free_mid]="${yellow1}"
theme[free_end]="${red1}"

# Mem/Disk cached meter
theme[cached_start]="${green1}"
theme[cached_mid]="${yellow1}"
theme[cached_end]="${red1}"

# Mem/Disk available meter
theme[available_start]="${green1}"
theme[available_mid]="${yellow1}"
theme[available_end]="${red1}"

# Mem/Disk used meter
theme[used_start]="${green1}"
theme[used_mid]="${yellow1}"
theme[used_end]="${red1}"

# Download graph colors
theme[download_start]="${green1}"
theme[download_mid]="${yellow1}"
theme[download_end]="${red1}"

# Upload graph colors
theme[upload_start]="${green1}"
theme[upload_mid]="${yellow1}"
theme[upload_end]="${red1}"

# Process box color gradient for threads, mem and cpu usage
theme[process_start]="${green1}"
theme[process_mid]="${yellow1}"
theme[process_end]="${red1}"]],
		schema
	)

	return template
end

return M
