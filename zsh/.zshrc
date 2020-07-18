#!/bin/zsh

# THEME
ZSH_THEME="spaceship"
SPACESHIP_PROMPT_ADD_NEWLINE=(false)

# PLUGINS VARIABLES
export NVM_COMPLETION=true

# PLUGINS
plugins=(git common-aliases docker docker-compose zsh-nvm poetry flutter thefuck copydir copyfile command-not-found colored-man-pages zsh-autosuggestions zsh-syntax-highlighting zsh-completions)

# ENV VARIABLES
export ZSH="$HOME/.oh-my-zsh"
export ZSH_CUSTOM="$HOME/dotfiles/zsh/custom"

export ANDROID_HOME="$HOME/development/devtools/android-sdk"
export JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64"

export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin" # Default PATH
export PATH="$HOME/development/devtools/flutter-sdk/bin:$PATH" # Flutter
export PATH="$HOME/.symfony/bin:$PATH" # Symfony
export PATH="$HOME/.yarn/bin:$PATH" # Yarn
export PATH=".:$PATH" # Current directory

# THE FUCK
eval $(thefuck --alias joder)

# AUTOCOMPLETION FIXING TRICK
if ls $HOME/.zcompdump* 1> /dev/null 2>&1; then
    rm -rf $HOME/.zcompdump*
fi

# ENABLE GLOBAL SYNTAX
setopt extended_glob

if test -f $HOME/dotfiles/zsh/private_config.zsh; then
    source $HOME/dotfiles/zsh/private_config.zsh
fi

source $ZSH/oh-my-zsh.sh
