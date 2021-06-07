# My ZSH config
_exists() { (( $+commands[$1] )) }

if test -e "/opt/homebrew/bin/brew"; then
	eval "$(/opt/homebrew/bin/brew shellenv)"
	FPATH=$(brew --prefix)/share/zsh-completions:$(brew --prefix)/share/zsh/site-functions:$FPATH
fi

source ~/.dotfiles/zinit/zinit.zsh
bindkey -e

zstyle :compinstall filename "$HOME/.zshrc"

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
unsetopt BEEP

autoload -Uz compinit
compinit

# History
setopt append_history
setopt inc_append_history
setopt extended_history 
setopt hist_no_store
setopt no_bang_hist
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_ignore_space
HISTFILE=~/.histfile
HISTSIZE=11000
SAVEHIST=10000
HISTORY_IGNORE='(clear|cd ..|cd -)'

autoload -Uz up-line-or-beginning-search down-line-or-beginning-search

zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

bindkey '^[[A'  up-line-or-beginning-search
bindkey '^[OA'  up-line-or-beginning-search
bindkey '^[[B'  down-line-or-beginning-search
bindkey '^[OB'  down-line-or-beginning-search

# Aliases
_exists exa && alias ls="exa --long --git"
_exists bat && alias cat="bat"
_exists rg && alias grep="rg"

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

alias oktest="yarn test"
alias oktestw="yarn test --watch"
alias okdeploy="yarn hydra:ingest --env ACrnkovic --debug && yarn hydra:deploy --env ACrnkovic"

# Prompt and editor
export PROMPT="%~ $ "
export EDITOR="vim"
export GPG_TTY=$(tty)

# Calculator
autoload -U zcalc
alias zc >/dev/null && unalias zc
zc() { [[ -n "$@" ]] && zcalc -e $@ || zcalc }
alias zc='noglob zc'

# Plugins
zinit light zsh-users/zsh-completions
zinit light trystan2k/zsh-tab-title
zinit light zsh-users/zsh-syntax-highlighting

zinit ice as"completion"
zinit snippet https://github.com/docker/cli/blob/master/contrib/completion/zsh/_docker

# Extending
if test -e $HOME/.dotfiles/secret.sh; then
	source $HOME/.dotfiles/secret.sh
fi

if test -e $HOME/.dotfiles/functions.sh; then
	source $HOME/.dotfiles/functions.sh
fi

# Z command
if test -e $HOME/.dotfiles/z/z.sh; then
	source $HOME/.dotfiles/z/z.sh
fi

if _exists rbenv; then
	eval "$(rbenv init -)"
fi
