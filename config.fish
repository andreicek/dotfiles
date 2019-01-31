alias m="multipass"
alias loc="git ls-files | xargs cat | wc -l"
## GIT
alias gco="git checkout"
alias gst="git status -sb"
alias gc="git commit"
alias gcm="git commit -m"
alias ga="git add"
alias gaa="git add -A"
alias gap="git add --patch"
alias gpl="git pull"
alias gps="git push"


alias ugh="del node_modules/ && yarn install"

alias ..="cd .."
alias aws_creds="cat ~/.aws/credentials | grep '\[' | awk -F'[][]' '{print $2}'"

alias map="xargs -n1"

alias pubip="dig +short myip.opendns.com @resolver1.opendns.com"

set --global EDITOR "vim"
set -gx PATH ~/.dotfiles/bin $PATH
