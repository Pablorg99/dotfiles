# THEME
ZSH_THEME="spaceship"
SPACESHIP_PROMPT_ADD_NEWLINE=(false)

# PLUGINS
plugins=(git common-aliases docker docker-compose thefuck copydir copyfile command-not-found colored-man-pages zsh-autosuggestions zsh-syntax-highlighting zsh-completions)

# ENV VARIABLES
export ZSH="$HOME/.oh-my-zsh"
export ZSH_CUSTOM="$HOME/dotfiles/zsh/custom"

export ANDROID_HOME="$HOME/development/devtools/android-sdk"
export JAVA_HOME="/usr/lib/jvm/java-11-openjdk-amd64"

export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin" # Default PATH
export PATH="$HOME/development/devtools/flutter-sdk/bin:$PATH" # Flutter
export PATH="$HOME/.yarn/bin:$PATH" # Yarn
export PATH=".:$PATH" # Current directory


# THE FUCK
eval $(thefuck --alias joder)

source $ZSH/oh-my-zsh.sh
