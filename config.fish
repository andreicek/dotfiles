# ENVs
set -gx EDITOR "vim"
set -gx PATH ~/.dotfiles/bin $PATH

# Source secrets file if there is one
if test -f $HOME/.config/fish/secret.fish
  source ~/.config/fish/secret.fish
end

# Misc
alias m="multipass"
alias loc="git ls-files | xargs cat | wc -l"
alias pubip="dig +short myip.opendns.com @resolver1.opendns.com"
alias ugh="del node_modules/ && yarn install"
alias map="xargs -n1"
alias ls="exa --long --git"

# Git alias
alias gco="git checkout"
alias gst="git status -sb"
alias gc="git commit"
alias gcm="git commit -m"
alias ga="git add"
alias gaa="git add -A"
alias gap="git add --patch"
alias gpl="git pull"
alias gps="git push"

# My prompt
function fish_prompt
  echo (hostname)'% '
end

#wather
function weather
  curl "wttr.in/$1"
end
