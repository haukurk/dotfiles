#!/bin/bash
# Making things simple, with a simple installation script.

dotfiles_dir=~/dotfiles
bakdir=~/dotfiles_bak
dotfiles="bashrc vimrc vim gitconfig aliases"

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Basic dotfiles install.
echo -n "Creating $bakdir for backup of any existing dotfiles in ~ ..."
mkdir -p $bakdir
echo "done"
echo -n "Changing to the $dotfiles_dir directory ..."
cd $dotfiles_dir
echo "done"
for file in $dotfiles; do
    echo "Moving any existing dotfiles from ~ to $bakdir"
    mv ~/.$file ~/dotfiles_bak/                                                                                                         
    echo "Creating symlink to $file in home directory."
    ln -s $dotfiles_dir/$file ~/.$file
done

# Install VIM Plugins with Vundle
vim +PluginInstall +qall
