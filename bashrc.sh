# ~/.bashrc

shopt -s promptvars
PS1="\[\033[37m\]\w% \[\e]0;\W\a\]"
PS1='$(printf "%$((COLUMNS-1))s\r")'$PS1

shopt -s histappend
export PROMPT_COMMAND="history -a; history -n"
export HISTCONTROL="ignoreboth"
export HISTIGNORE="pwd:exit:clear"
export HISTSIZE="-1"
export HISTFILESIZE="-1"
export HISTTIMEFORMAT="[%d/%m/%y %T] "

export EDITOR="emacs"

alias vim="emacs"

if command -v exa 2>/dev/null >/dev/null; then
  alias ls="exa --long --git"
fi

if command -v bat 2>/dev/null >/dev/null; then
  alias cat="bat"
fi

if command -v rg 2>/dev/null >/dev/null; then
  alias grep="rg"
fi

eval $(ssh-agent) > /dev/null
ssh-add 2>/dev/null

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

alias pubkey="cat ~/.ssh/*.pub"
alias bin="pastebinit -b https://pastebinit.crnkovic.family"

alias okdeploy="yarn hydra:ingest --env ACrnkovic --debug && yarn hydra:deploy --env ACrnkovic"
alias oktest="yarn test"
alias oktestw="yarn test --watch"

if test -r "/usr/local/etc/profile.d/bash_completion.sh"; then
  source /usr/local/etc/profile.d/bash_completion.sh
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