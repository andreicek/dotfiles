source ~/.dotfiles/zinit/bin/zinit.zsh

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/andreicek/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

export PROMPT="%~$ "
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

if test -e $HOME/.dotfiles/secret.sh; then
  source $HOME/.dotfiles/secret.sh
fi

if test -e $HOME/.dotfiles/z.sh; then
  source $HOME/.dotfiles/z.sh
fi

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

autoload -Uz up-line-or-beginning-search down-line-or-beginning-search

zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

bindkey '^[[A'  up-line-or-beginning-search    # Arrow up
bindkey '^[OA'  up-line-or-beginning-search
bindkey '^[[B'  down-line-or-beginning-search  # Arrow down
bindkey '^[OB'  down-line-or-beginning-search

zinit light trystan2k/zsh-tab-title