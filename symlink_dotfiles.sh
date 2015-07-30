#!/bin/bash
echo "linking dotfiles to home directory"

FILES="gemrc
gitconfig
irbrc
my.cnf
zshrc"

for file in $FILES
do
  ln -s ~/development/dotfiles/$file ~/.$file
done
