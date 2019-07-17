# Remove files if they exist
if [ -f $HOME/.gitconfig ]; then
    rm -rf $HOME/.gitconfig
fi

if [ -f $HOME/.apt-vim ]; then
    rm -rf $HOME/.apt-vim
fi

if [ -f $HOME/.vimrc ]; then
    rm -rf $HOME/.vimrc
fi

if [ -f $HOME/.zshrc ]; then
    rm -rf $HOME/.zshrc
fi

# SOFT LINKS
# Git
ln -s $HOME/dotfiles/git/gitconfig $HOME/.gitconfig
# Vim
ln -s $HOME/dotfiles/vim/apt-vim $HOME/.apt-vim
ln -s $HOME/dotfiles/vim/vimrc $HOME/.vimrc
# Zsh
ln -s $HOME/dotfiles/zsh/zshrc $HOME/.zshrc
