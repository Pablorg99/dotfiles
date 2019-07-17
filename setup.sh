# Remove soft links for update if they existed already

if [ -f $HOME/.gitconfig ]; then
    rm -rf $HOME/.gitconfig
fi

if [ -f $HOME/.vimrc ]; then
    rm -rf $HOME/.vimrc
fi

if [ -f $HOME/.zshrc ]; then
    rm -rf $HOME/.zshrc
fi

# Create all soft links

# Git
ln -s $HOME/dotfiles/git/gitconfig $HOME/.gitconfig
# Vim
ln -s $HOME/dotfiles/vim/vimrc $HOME/.vimrc
# Zsh
ln -s $HOME/dotfiles/zsh/zshrc $HOME/.zshrc
