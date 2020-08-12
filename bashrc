PS1="\[\033[37m\]\w% \[\033[90m\]\[\e]0;\W\a\]"

if [ -f /usr/local/share/bash-completion/bash_completion ]; then
  source /usr/local/share/bash-completion/bash_completion
fi

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
alias food="productive-cli clock --service food"
alias bin="pastebinit -b https://pastebinit.crnkovic.family"

alias wb="productive-cli clock --service 0 --note development --time"
alias deploy="yarn hydra:deploy --env ACrnkovic"

alias ..="cd .."

alias scrapvm="docker run -ti --rm ubuntu"
alias upload="rsync -avzu --progress"
alias http="curlie"

function git_remote_init() {
  repo=$1
  if [ ! "$repo" = "" ]; then
    ssh git@git.crnkovic.family "mkdir $repo.git; cd $repo.git; git init --bare"
    echo "git remote add local git@git.crnkovic.family:$repo.git"
  fi
}

export EDITOR="vim"
export PATH="$PATH:$HOME/.dotfiles/bin"

if test -e $HOME/.dotfiles/secret.sh; then
  source $HOME/.dotfiles/secret.sh
fi
