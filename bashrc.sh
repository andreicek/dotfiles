# ~/.bashrc

shopt -s promptvars
PS1="\[\033[37m\]\w\$ \[\e]0;\W\a\]"
PS1='$(printf "%$((COLUMNS-1))s\r")'$PS1

shopt -s histappend
export PROMPT_COMMAND="history -a; history -n"
export HISTCONTROL="ignoreboth"
export HISTIGNORE="pwd:exit:clear"
export HISTSIZE="-1"
export HISTFILESIZE="-1"
export HISTTIMEFORMAT="[%d/%m/%y %T] "

export EDITOR="vim"

if command -v exa 2>/dev/null >/dev/null; then
  alias ls="exa --long --git"
fi

if command -v bat 2>/dev/null >/dev/null; then
  alias cat="bat"
fi

if command -v rg 2>/dev/null >/dev/null; then
  alias grep="rg"
fi

if command -v clip.exe 2>/dev/null >/dev/null; then
  alias pbcopy="clip.exe"
fi

eval $(ssh-agent) > /dev/null
ssh-add 2>/dev/null

alias map="xargs -n1"
alias ..="cd .."  

alias gco="git checkout"
alias gst="git status -sb"
alias gc="git commit"
alias gcm="git commit -m"
alias ga="git add"
alias gaa="git add -A"
alias gap="git add --patch"
alias gpl="git pull"
alias gps="git push"

alias pubkey="cat ~/.ssh/*.pub"
alias bin="pastebinit -b https://pastebinit.crnkovic.family"
alias backup="borgmatic --config ~/.dotfiles/borgmatic.yaml -v 1"

alias okdeploy="yarn hydra:ingest --env ACrnkovic --debug && yarn hydra:deploy --env ACrnkovic"
alias oktest="yarn test"
alias oktestw="yarn test --watch"

alias oklog="vim ~/my-log.txt"

if test -r "/usr/share/bash-completion/bash_completion"; then
  source /usr/share/bash-completion/bash_completion
  __git_complete gco _git_checkout
  __git_complete gst _git_status
  __git_complete gc _git_commit
  __git_complete gcm _git_commit
  __git_complete ga _git_add
  __git_complete gaa _git_add
  __git_complete gap _git_add
  __git_complete gpl _git_pull
  __git_complete gps _git_push
fi

if test -e $HOME/.dotfiles/secret.sh; then
  source $HOME/.dotfiles/secret.sh
fi

if test -e $HOME/.dotfiles/z.sh; then
  source $HOME/.dotfiles/z.sh
fi
