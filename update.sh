#!/bin/zsh

# CREATE OR UPDATE SOFT LINKS
ln -sfn $HOME/dotfiles/zsh/.zshrc $HOME/.zshrc
ln -sfn $HOME/dotfiles/vim/.vimrc $HOME/.vimrc
ln -sfn $HOME/dotfiles/git/.gitconfig $HOME/.gitconfig
mkdir -p $HOME/.config/Code/User/ && ln -sfn $HOME/dotfiles/code/settings.json $HOME/.config/Code/User/settings.json
ln -sfn $HOME/dotfiles/python/.pylintrc $HOME/.pylintrc
mkdir -p $HOME/.config/tilda/ && /bin/cp -rf $HOME/dotfiles/tilda/config_0 $HOME/.config/tilda/config_0

# RELOAD SHELL CONFIGURATION
source $HOME/.zshrc
