###
# Path
###

fish_add_path /opt/homebrew/bin
fish_add_path ~/.local/bin/

###
# Variables
###

set -Ux EDITOR nvim
set -Ux GPG_TTY "$(tty)"
set -Ux ERL_AFLAGS "-kernel shell_history enabled"
set fish_greeting

###
# Plugins
###

zoxide init fish | source
mise activate fish | source
mise completion fish | source
fzf --fish | source
