export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="evan"
plugins=(
  git
)

source $ZSH/oh-my-zsh.sh
source ~/Projects/dotfiles/secrets.sh

export LANG=en_US.UTF-8
export EDITOR=nvim

alias m="multipass"
alias loc="git ls-files | xargs cat | wc -l"
alias reload="source ~/.zshrc"
alias gco="git checkout"
alias gst="git status -sb"
alias gc="git commit"
alias gcm="git commit -m"
alias ga="git add"
alias gaa="git add -A"
alias gap="git add --patch"
alias gpl="git pull"
alias gps="git push"
alias mux="tmuxinator start"
alias ugh="del node_modules/ && yarn install"
alias awk="gawk"
alias ..="cd .."
alias crontab="VIM_CRONTAB=true crontab"
alias aws_creds="cat ~/.aws/credentials | grep '\[' | awk -F'[][]' '{print $2}'"
alias nw="/Applications/node-webkit.app/Contents/MacOS/node-webkit"
alias vnc="open vnc://$AMK_KIOSK_IP"
alias vim="nvim"
alias map="xargs -n1"
alias pubip="dig +short myip.opendns.com @resolver1.opendns.com"

tab-color() {
  echo -ne "\033]6;1;bg;red;brightness;$1\a"
  echo -ne "\033]6;1;bg;green;brightness;$2\a"
  echo -ne "\033]6;1;bg;blue;brightness;$3\a"
}

tab-reset() {
  echo -ne "\033]6;1;bg;*;default\a"
}

vpn() {
  tab-color 255 0 0

  sudo /usr/local/opt/openvpn/sbin/openvpn --config ~/macbookpro.ovpn

  tab-reset
}
