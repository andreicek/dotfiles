#!/usr/bin/env bash

if grep -q "Darwin" <<< $(uname -a); then
  if [ ! -x "$(command -v brew)" ]; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi

  brew install exa git node postgresql rbenv bat fish httpie n ripgrep jq starship

  brew cask install visual-studio-code google-chrome \
    firefox slack 1password docker iterm2 imageoptim \
    resilio-sync spotify tableplus zoomus whatsapp

  if ! grep -q "auth sufficient pam_tid.so" /etc/pam.d/sudo; then
    awk 'NR==2{print "auth sufficient pam_tid.so"}1' /etc/pam.d/sudo | sudo tee /etc/pam.d/sudo
  fi

  sudo mkdir -p /usr/local/n
  sudo chown -R $(whoami):staff /usr/local/n

  code --install-extension dbaeumer.vscode-eslint
  code --install-extension esbenp.prettier-vscode
  code --install-extension ms-azuretools.vscode-docker
  code --install-extension ms-vscode.vscode-typescript-tslint-plugin
  code --install-extension sianglim.slim
  code --install-extension skyapps.fish-vscode
  code --install-extension tootone.org-mode
  
  ln -s $HOME/.dotfiles/settings.json $HOME/Library/Application\ Support/Code/User/settings.json
fi

if ! grep -q "$(which fish)" /etc/shells; then
  which fish | sudo tee -a /etc/shells
fi
chsh -s $(which fish)

n lts

cd $HOME
git clone https://github.com/andreicek/dotfiles .dotfiles

mkdir -p $HOME/.config/fish
ln -s $HOME/.dotfiles/config.fish $HOME/.config/fish/config.fish

ln -s $HOME/.dotfiles/gitconfig $HOME/.gitconfig

ln -s $HOME/.dotfiles/vimrc $HOME/.vimrc

cd $HOME/.dotfiles
git remote set-url origin git@github.com:andreicek/dotfiles.git
