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
# Aliases
###

alias ls="eza --icons"
alias gco="git checkout"
alias gst="git status -sb"
alias gc="git commit"
alias gcm="git commit -m"
alias ga="git add"
alias gaa="git add -A"
alias gap="git add --patch"
alias gpl="git pull -r"
alias gps="git push"
alias gl="git log --oneline"
alias cat="bat --theme=ansi"
alias rm="trash"
alias vim="nvim"

###
# Plugins
###

zoxide init fish | source
mise activate fish | source
starship init fish | source
