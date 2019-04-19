#!/bin/bash

set -e

if [ ! -d ~/code/dotfiles ]; then
  echo "Cloning dotfiles"
  cd ~/code
  git clone --recursive https://github.com/gabeleibo/dotfiles.git
fi

cd ~/code/dotfiles
git remote set-url origin git@github.com:gabeleibo/dotfiles.git

ln -sf $(pwd)/vimrc ~/.vim_runtime/my_configs.vim
ln -sf $(pwd)/zshrc ~/.zshrc
ln -sf $(pwd)/zsh ~/.zsh
ln -sf $(pwd)/tmux.config ~/.tmux.conf
ln -sf $(pwd)/gitconfig ~/.gitconfig
ln -sf $(pwd)/sshconfig ~/.ssh/config

/usr/sbin/sshd -D
