#!/bin/bash

set -e

if [ ! -d ~/code/dotfiles ]; then
  echo "Cloning dotfiles"
  cd ~/code
  git clone --recursive https://github.com/gabeleibo/dotfiles.git
fi

cd ~/code/dotfiles
git remote set-url origin git@github.com:gabeleibo/dotfiles.git

ln -s $(pwd)/vimrc ~/.vimrc
ln -s $(pwd)/zshrc ~/.zshrc
ln -s $(pwd)/tmux.conf ~/.tmux.conf
ln -s $(pwd)/gitconfig ~/.gitconfig
ln -s $(pwd)/sshconfig ~/.ssh/config


/usr/sbin/sshd -D
