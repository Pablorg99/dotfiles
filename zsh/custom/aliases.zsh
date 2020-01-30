# TERMINAL USE
alias rf="rm -rf"
alias poweroff="systemctl poweroff -i"
alias reboot="systemctl reboot -i"

# META ALIASES
alias aliases="vim $HOME/dotfiles/zsh/custom/aliases.zsh"
alias dotfiles-update="source $HOME/dotfiles/update.sh"

# DIRECTORIES
alias asl="cd $HOME/development/repositories/asl"
alias uni="cd $HOME/development/repositories/university"
alias sp="cd $HOME/development/repositories/sideprojects"

# REPOSITORIES
alias djangorecipes="cd $HOME/development/repositories/sideprojects/django-recipes && source venv/bin/activate"
alias reactrecipes="cd $HOME/development/repositories/sideprojects/react-recipes"
alias ucopuntomobile="cd $HOME/development/repositories/sideprojects/ucopunto-mobile"
alias practicesuco="cd $HOME/development/repositories/university/UCO-Practices"

# TEMPLATES
alias templatex="cp $HOME/dotfiles/templates/latexTemplate.tex . && mv latexTemplate.tex"
alias tskata="cp -r $HOME/dotfiles/templates/typescript-kata-template/. ."
alias pykata="cp -r $HOME/dotfiles/templates/python-kata-template/. ."

# VENV
alias venv="source venv/bin/activate"
alias new-venv="virtualenv -p python3 venv && source venv/bin/activate"

# OTHERS
alias ucossh="ssh i72rogup@ts.uco.es"
