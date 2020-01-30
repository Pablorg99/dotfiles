# THEME
ZSH_THEME="spaceship"
SPACESHIP_PROMPT_ADD_NEWLINE=(false)

# PLUGINS
plugins=(git zsh-completions docker docker-compose colored-man-pages command-not-found copydir copyfile cp common-aliases zsh-autosuggestions zsh-syntax-highlighting)

# ENV VARIABLES
export ZSH="$HOME/.oh-my-zsh"
export ZSH_CUSTOM="$HOME/dotfiles/zsh/custom"

export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
export PATH="$HOME/development/devtools/flutter/bin:$PATH"
export PATH="$HOME/.yarn/bin:$PATH"
export PATH=".:$PATH"

export ANDROID_HOME="$HOME/development/devtools/android-sdk"

source $ZSH/oh-my-zsh.sh
