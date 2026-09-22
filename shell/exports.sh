# ------------------------------------------------------------------------------
# Codely theme config
# ------------------------------------------------------------------------------
export CODELY_THEME_MINIMAL=false
export CODELY_THEME_MODE="dark"
export CODELY_THEME_PROMPT_IN_NEW_LINE=false
export CODELY_THEME_PWD_MODE="short" # full, short, home_relative

# ------------------------------------------------------------------------------
# Languages
# ------------------------------------------------------------------------------
# JAVA_HOME is set per project by the active version manager, not globally.
export GEM_HOME="$HOME/.gem"
export GOPATH="$HOME/.go"

# ------------------------------------------------------------------------------
# Apps
# ------------------------------------------------------------------------------
if [ "$CODELY_THEME_MODE" = "dark" ]; then
	fzf_colors="pointer:#ebdbb2,bg+:#3c3836,fg:#ebdbb2,fg+:#fbf1c7,hl:#8ec07c,info:#928374,header:#fb4934"
else
	fzf_colors="pointer:#db0f35,bg+:#d6d6d6,fg:#808080,fg+:#363636,hl:#8ec07c,info:#928374,header:#fffee3"
fi

export FZF_DEFAULT_OPTS="--color=$fzf_colors --reverse"

# ------------------------------------------------------------------------------
# SSH
# ------------------------------------------------------------------------------
# Use Bitwarden Desktop as SSH agent (macOS, installed via dmg/brew).
# For App Store install, change to:
#   $HOME/Library/Containers/com.bitwarden.desktop/Data/.bitwarden-ssh-agent.sock
export SSH_AUTH_SOCK="$HOME/.bitwarden-ssh-agent.sock"

# ------------------------------------------------------------------------------
# Path - The higher it is, the more priority it has
# ------------------------------------------------------------------------------
path=(
	"$HOME/bin"
	"$DOTLY_PATH/bin"
	"$DOTFILES_PATH/bin"
	"$GEM_HOME/bin"
	"$GOPATH/bin"
	"$HOME/.cargo/bin"
	"$HOME/.bun/bin"
	"/usr/local/opt/ruby/bin"
	"/usr/local/opt/python/libexec/bin"
	"/opt/homebrew/bin"
	"/usr/local/bin"
	"/usr/local/sbin"
	"/bin"
	"/usr/bin"
	"/usr/sbin"
	"/sbin"
	"$path"
)

export path
