#!/bin/zsh

# CREATE OR UPDATE SOFT LINKS
ln -sfn $HOME/dotfiles/zsh/.zshrc $HOME/.zshrc
ln -sfn $HOME/dotfiles/vim/.vimrc $HOME/.vimrc
ln -sfn $HOME/dotfiles/git/.gitconfig $HOME/.gitconfig
ln -sfn $HOME/dotfiles/code/settings.json $HOME/.config/Code/User/settings.json
ln -sfn $HOME/dotfiles/python/.pylintrc $HOME/.pylintrc

# RELOAD SHELL CONFIGURATION
source $HOME/.zshrc
