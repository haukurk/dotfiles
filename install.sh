#!/bin/bash

dotfiles_dir=~/dotfiles
bakdir=~/dotfiles_bak
dotfiles="bashrc vimrc vim"

# Basic dotfiles install.
echo -n "Creating $bakdir for backup of any existing dotfiles in ~ ..."
mkdir -p $bakdir
echo "done"
echo -n "Changing to the $dotfiles_dir directory ..."
cd $dotfiles_dir
echo "done"
for file in $files; do
    echo "Moving any existing dotfiles from ~ to $olddir"
    mv ~/.$file ~/dotfiles_old/
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file ~/.$file
done
