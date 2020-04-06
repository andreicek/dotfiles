PS1="\$ \[\e]0;\W\a\]"

if command -v exa 2>/dev/null >/dev/null; then
  alias ls="exa --long --git"
fi

if command -v trash 2>/dev/null >/dev/null; then
  alias rm="trash"
fi

if command -v bat 2>/dev/null >/dev/null; then
  alias cat="bat"
fi

if command -v rg 2>/dev/null >/dev/null; then
  alias grep="rg"
fi

alias map="xargs -n1"
alias gco="git checkout"
alias gst="git status -sb"
alias gc="git commit"
alias gcm="git commit -m"
alias ga="git add"
alias gaa="git add -A"
alias gap="git add --patch"
alias gpl="git pull"
alias gps="git push"

alias ..="cd .."

alias scrapvm="docker run -ti --rm ubuntu"
alias upload="rsync -avzu --progress"
alias http="curlie"

export EDITOR="vim"
export PATH="$PATH:$HOME/.dotfiles/bin"

if test -e $HOME/.dotfiles/secret.sh; then
  source $HOME/.dotfiles/secret.sh
fi
