# ~/.bashrc: executed by bash for non-login shells.

PS1="\[\033[37m\]\w% \[\e]0;\W\a\]"

shopt -s histappend
export PROMPT_COMMAND='history -a; history -n'
export HISTCONTROL='ignoreboth'
export HISTIGNORE='pwd:exit:clear'
export HISTSIZE='-1'
export HISTFILESIZE='-1'
export HISTTIMEFORMAT='[%d/%m/%y %T] '

if command -v exa 2>/dev/null >/dev/null; then
  alias ls="exa --long --git"
fi

if command -v bat 2>/dev/null >/dev/null; then
  alias cat="bat"
fi

if command -v rg 2>/dev/null >/dev/null; then
  alias grep="rg"
fi

alias map="xargs -n1"
alias ..="cd .."

alias http="curlie"

alias gco="git checkout"
alias gst="git status -sb"
alias gc="git commit"
alias gcm="git commit -m"
alias ga="git add"
alias gaa="git add -A"
alias gap="git add --patch"
alias gpl="git pull"
alias gps="git push"
alias food="productive-cli clock --service food"
alias bin="pastebinit -b https://pastebinit.crnkovic.family"

alias d="yarn hydra:deploy --env ACrnkovic"
alias t="yarn test"
alias tw="yarn test --watch"

export EDITOR="vim"
export PATH="$PATH:$HOME/.dotfiles/bin"

if test -e $HOME/.dotfiles/secret.sh; then
  source $HOME/.dotfiles/secret.sh
fi
