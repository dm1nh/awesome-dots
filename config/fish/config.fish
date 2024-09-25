#
# ███████╗██╗░██████╗██╗░░██╗
# ██╔════╝██║██╔════╝██║░░██║
# █████╗░░██║╚█████╗░███████║
# ██╔══╝░░██║░╚═══██╗██╔══██║
# ██║░░░░░██║██████╔╝██║░░██║
# ╚═╝░░░░░╚═╝╚═════╝░╚═╝░░╚═╝
#
# Created by: Dang Minh Ngo
# Github: @dm1nh
# Email: dangminhngo.dev@gmail.com

# Disable fish_greeting
set -U fish_greeting

set -Ux PNPM_HOME $HOME/.local/share/pnpm

# Add paths
fish_add_path -g ~/.local/bin $PNPM_HOME

set fish_color_valid_path

if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Alias
alias ll "ls -la"
alias ga "git add -A"
alias gp "git push"
alias n nvim

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
