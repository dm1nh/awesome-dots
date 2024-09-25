# Interstellar colorscheme for Fish
# ~/.config/fish/conf.d/theme.fish

# --> special
set -l fg bfc0c2
set -l sel 282c34

# --> palette
set -l red e06c75
set -l green 98c379
set -l yellow e5c07b
set -l orange ffa066
set -l blue 61afef
set -l purple c678dd
set -l magenta dd78b3
set -l cyan 65cdb4
set -l black 696b71

# Syntax Highlighting
set -g fish_color_normal $fg
set -g fish_color_command $green
set -g fish_color_param $fg
set -g fish_color_keyword $red
set -g fish_color_quote $green
set -g fish_color_redirection $purple
set -g fish_color_end $orange
set -g fish_color_error $red
set -g fish_color_gray $black
set -g fish_color_selection --background=$sel
set -g fish_color_search_match --background=$sel
set -g fish_color_operator $blue
set -g fish_color_escape $purple
set -g fish_color_autosuggestion $black
set -g fish_color_cancel $red

# Prompt
set -g fish_color_cwd $yellow
set -g fish_color_user $cyan
set -g fish_color_host $blue

# Completion Pager
set -g fish_pager_color_progress $black
set -g fish_pager_color_prefix $purple
set -g fish_pager_color_completion $fg
set -g fish_pager_color_description $black
    