# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="sammy"

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

plugins=(brew z python virtualenvwrapper zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# User configuration
export DOTFILES="$HOME/.dotfiles"
source $DOTFILES/secret.sh

export EDITOR='vim'
export GPG_TTY=$(tty)

alias gco="git checkout"
alias gst="git status -sb"
alias gc="git commit"
alias gcm="git commit -m"
alias ga="git add"
alias gaa="git add -A"
alias gap="git add --patch"
alias gpl="git pull"
alias gps="git push"

eval $(/opt/homebrew/bin/brew shellenv)
