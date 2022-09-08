export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="lambda"

plugins=(brew z asdf zsh-fzf-history-search zsh-syntax-highlighting zsh-autosuggestions)

export EDITOR='nvim'
export GPG_TTY=$(tty)
export ERL_AFLAGS="-kernel shell_history enabled"

alias gco="git checkout"
alias gst="git status -sb"
alias gc="git commit"
alias gcm="git commit -m"
alias ga="git add"
alias gaa="git add -A"
alias gap="git add --patch"
alias gpl="git pull"
alias gps="git push"

alias vim="nvim"
alias cat="bat"
alias printer="lpr -o sides=two-sided-long-edge"

source $ZSH/oh-my-zsh.sh
