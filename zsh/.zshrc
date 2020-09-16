#!/bin/zsh

# THEME
ZSH_THEME="spaceship"
SPACESHIP_PROMPT_ADD_NEWLINE=(false)

# PLUGINS VARIABLES
export NVM_COMPLETION=true

# PLUGINS
plugins=(git common-aliases autojump fzf docker docker-compose zsh-nvm poetry flutter thefuck copydir copyfile command-not-found colored-man-pages zsh-autosuggestions zsh-syntax-highlighting zsh-completions)

# ENV VARIABLES
export ZSH="$HOME/.oh-my-zsh"
export ZSH_CUSTOM="$HOME/dotfiles/zsh/custom"

export ANDROID_HOME="$HOME/development/devtools/android-sdk"
export JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64"

DEFAULT_PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
FLUTTER="$HOME/development/devtools/flutter-sdk/bin"
SYMFONY="$HOME/.symfony/bin"
YARN="$HOME/.yarn/bin"
SNAP="/snap/bin"
CURRENT="."

export PATH="$DEFAULT_PATH:$FLUTTER:$DART:$SYMFONY:$YARN:$SNAP:$CURRENT"

# THE FUCK
eval $(thefuck --alias joder)

# AUTOCOMPLETION FIXING TRICK
if ls "$HOME/.zcompdump"* 1> /dev/null 2>&1; then
    rm -rf $HOME/.zcompdump*
fi

# ENABLE GLOBAL SYNTAX
setopt extended_glob

if [ -f $HOME/dotfiles/zsh/private_config.zsh ]; then
    source $HOME/dotfiles/zsh/private_config.zsh
fi

source $ZSH/oh-my-zsh.sh
