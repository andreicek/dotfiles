#!/usr/bin/env

echo "Setting up dotfiles"

cd $HOME
git clone https://github.com/andreicek/dotfiles .dotfiles

echo -n "Fish shell"
mkdir -p $HOME/.config/fish
ln -s $HOME/.dotfiles/config.fish $HOME/.config/fish/config.fish
echo " done."

echo -n "Git"
ln -s $HOME/.dotfiles/gitconfig $HOME/.gitconfig
echo " done."

echo -n "Vim"
ln -s $HOME/.dotfiles/vimrc $HOME/.vimrc
echo " done."