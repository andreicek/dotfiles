export PATH="/usr/local/bin:/usr/bin:/bin:$HOME/.local/bin:$PATH"

HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS

export EDITOR=vim
export GPG_TTY=$(tty)
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
export ERL_AFLAGS="-kernel shell_history enabled"

alias cat='batcat --theme=ansi'
alias ls='eza --icons'
alias pbcopy='wl-copy'

alias gco="git checkout"
alias gst="git status -sb"
alias gc="git commit"
alias gcm="git commit -m"
alias ga="git add"
alias gaa="git add -A"
alias gap="git add --patch"
alias gpl="git pull -r"
alias gps="git push"
alias gl="git log --oneline"

autoload -Uz compinit && compinit

setopt PROMPT_SUBST

function _git_prompt_info() {
  local branch
  branch=$(git symbolic-ref --short HEAD 2>/dev/null) || return
  local dirty=""
  if [ -n "$(git status --porcelain --ignore-submodules=dirty 2>/dev/null)" ]; then
    dirty=" %{$fg[yellow]%}✗%{$reset_color%}"
  fi
  echo " %{$fg[blue]%}git:(%{$fg[red]%}${branch}%{$fg[blue]%})%{$reset_color%}${dirty}"
}

autoload -U colors && colors
PROMPT='%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )%{$fg[cyan]%}%c%{$reset_color%}$(_git_prompt_info) '

eval "$(mise activate zsh)"
eval "$(mise exec -- gh completion -s zsh)"
eval "$(mise exec -- jira completion zsh)"

eval "$(zoxide init zsh)"
source <(fzf --zsh)

source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
