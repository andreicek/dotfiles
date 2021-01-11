source ~/.dotfiles/zinit/zinit.zsh

setopt append_history
setopt inc_append_history
setopt extended_history 
setopt hist_no_store
setopt no_bang_hist
setopt hist_ignore_dups
setopt hist_ignore_all_dups
HISTFILE=~/.histfile
HISTSIZE=11000
SAVEHIST=10000
HISTORY_IGNORE='([bf]g *|[bf]g|disown|cd ..|cd -)'

bindkey -e

zstyle :compinstall filename '/home/andreicek/.zshrc'

autoload -Uz compinit
compinit

_exists() { (( $+commands[$1] )) }

export PROMPT="%~$ "
export EDITOR="vim"

_exists exa && alias ls="exa --long --git"
_exists bat && alias cat="bat"
_exists rg && alias grep="rg"
_exists clip.exe && alias pbcopy="clip.exe"

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
alias backup="borgmatic --config ~/.dotfiles/borgmatic.yaml -v 1"

alias okdeploy="yarn hydra:ingest --env ACrnkovic --debug && yarn hydra:deploy --env ACrnkovic"
alias oktest="yarn test"
alias oktestw="yarn test --watch"

function cdtemp() {
  local temp=$(mktemp -d)
  echo "pushd $temp"
  pushd $temp
}

if test -e $HOME/.dotfiles/secret.sh; then
  source $HOME/.dotfiles/secret.sh
fi

if test -e $HOME/.dotfiles/functions.sh; then
  source $HOME/.dotfiles/functions.sh
fi

if test -e $HOME/.dotfiles/z.sh; then
  source $HOME/.dotfiles/z.sh
fi

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

autoload -Uz up-line-or-beginning-search down-line-or-beginning-search

zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

bindkey '^[[A'  up-line-or-beginning-search
bindkey '^[OA'  up-line-or-beginning-search
bindkey '^[[B'  down-line-or-beginning-search
bindkey '^[OB'  down-line-or-beginning-search

autoload -U zcalc
alias zc >/dev/null && unalias zc
zc() { [[ -n "$@" ]] && zcalc -e $@ || zcalc }
alias zc='noglob zc'

zinit light zsh-users/zsh-completions
zinit light trystan2k/zsh-tab-title
zinit light zsh-users/zsh-syntax-highlighting

zinit ice as"completion"
zinit snippet https://github.com/docker/cli/blob/master/contrib/completion/zsh/_docker

echo "$(whoami)@$HOST on $TTY; $(date)"