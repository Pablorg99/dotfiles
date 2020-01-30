# THEME
ZSH_THEME="spaceship"
SPACESHIP_PROMPT_ADD_NEWLINE=(false)

# PLUGINS
plugins=(git common-aliases docker docker-compose copydir copyfile command-not-found colored-man-pages zsh-autosuggestions zsh-syntax-highlighting zsh-completions)

# ENV VARIABLES
export ZSH="$HOME/.oh-my-zsh"
export ZSH_CUSTOM="$HOME/dotfiles/zsh/custom"

export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin" # Default PATH
export PATH="$HOME/development/devtools/flutter/bin:$PATH" # Flutter
export PATH="$HOME/.yarn/bin:$PATH" # Yarn
export PATH=".:$PATH" # Current directory

export ANDROID_HOME="$HOME/development/devtools/android-sdk"

source $ZSH/oh-my-zsh.sh
