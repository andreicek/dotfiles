export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="andrei-lambda-zsh-theme/andrei-lambda"

plugins=(z asdf zsh-fzf-history-search zsh-syntax-highlighting zsh-autosuggestions)

export EDITOR="micro"
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
alias gl="git log --oneline"
alias gll="git log --oneline | fzf --preview \"awk '{ print $1 }' <<< {} | xargs git wc\" | awk '{print $1 }'"

alias vim="nvim"
alias cat="bat"
alias printer="lpr -o sides=two-sided-long-edge"
alias rm="trash"
alias e="$EDITOR"

source $ZSH/oh-my-zsh.sh

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

