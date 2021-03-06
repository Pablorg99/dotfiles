source $HOME/dotfiles/zsh/custom/function_aliases.zsh

# TERMINAL USE
alias rf="rm -rf"
alias sysupdate="sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y && sudo apt autoclean"
alias poweroff="systemctl poweroff -i"
alias reboot="systemctl reboot -i"

# DIRECTORIES
alias sp="cd $HOME/development/repositories/sideprojects"
alias katas="cd $HOME/development/repositories/codekatas"
alias asl="cd $HOME/development/repositories/asl"
alias uni="cd $HOME/development/repositories/university"

# GIT
alias gunwip="git reset HEAD~1"

# TEMPLATES
alias templatex="createLatexProjectFromName"
alias tskata="createTypescriptKataFromName"
alias pykata="createPythonKataFromName"

# VENV
alias venv="source venv/bin/activate"
alias new-venv="virtualenv -p python3.7 venv && source venv/bin/activate"

# OTHERS
alias ucossh="ssh -X i72rogup@ts.uco.es"
alias ec2ssh="connectToEC2InstanceFromIP"
alias aliases="vim $HOME/dotfiles/zsh/custom/aliases.zsh"
alias ytdownload="youtube-dl -f best --restrict-filename -o '$HOME/Videos/%(title)s.%(ext)s'"
alias ytplaylist="youtube-dl -f best --restrict-filename -o '$HOME/Videos/%(playlist_index)s-%(title)s.%(ext)s'"
