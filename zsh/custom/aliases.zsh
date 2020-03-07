# FUNCTIONS
createLatexProjectFromName() {
    if [[ $# -ne 2 ]]; then
        mkdir $1
        cd $1
        cp -r $HOME/dotfiles/templates/latex/bibliography.bib $(pwd)
        cp $HOME/dotfiles/templates/latex/latexTemplate.tex $(pwd)
        mv latexTemplate.tex $1.tex
        mkdir static
        code $(pwd)
    else
        echo "Correct usage: templatex <project_name>"
    fi
}

createTypescriptKataFromName() {
    if [[ $# -ne 2 ]]; then
        mkdir $1
        cd $1
        cp -r $HOME/dotfiles/templates/typescript-kata-template/. $(pwd)
        mv src/kata.ts src/"$1".ts
        mv test/kata.spec.ts test/"$1".spec.ts
        sed -i "1s/.*/import Kata from '..\/src\/$1';/" test/"$1".spec.ts
        rm -rf .git
        yarn install
        git init
        git add --all
        git commit -m "Initial commit"
        code $(pwd)
    else
        echo "Correct usage: tskata <kata_name>"
    fi
}

createPythonKataFromName() {
    if [[ $# -ne 2 ]]; then
        mkdir $1
        cd $1
        cp -r $HOME/dotfiles/templates/python-kata-template/. $(pwd)
        mv src/kata.py src/"$1".py
        mv test/test_kata.py test/test_"$1".py
        sed -i "2s/.*/from src.$1 import Kata/" test/test_"$1".py
        rm -rf .git
        virtualenv -p python3 venv && source venv/bin/activate
        pip install -r requirements.txt
        git init
        git add --all
        git commit -m "Initial commit"
        code $(pwd)
    else
        echo "Correct usage: pykata <kata_name>"
    fi
}

connectToEC2InstanceFromIP() {
    if [[ $# -ne 2 ]]; then
        ssh ec2-user@"$1" -i $HOME/MEGA/Universidad/Tercero/Otros/AWS/PrivateKeyEC2.pem
    else
        echo "Correct usage: ec2ssh <instance_public_ip>"
    fi
}

# TERMINAL USE
alias rf="rm -rf"
alias sysupdate="sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y && sudo apt autoclean"
alias poweroff="systemctl poweroff -i"
alias reboot="systemctl reboot -i"

# META ALIASES
alias aliases="vim $HOME/dotfiles/zsh/custom/aliases.zsh"
alias dotfiles-update="source $HOME/dotfiles/update.sh"

# DIRECTORIES
alias sp="cd $HOME/development/repositories/sideprojects"
alias katas="cd $HOME/development/repositories/codekatas"
alias asl="cd $HOME/development/repositories/asl"
alias uni="cd $HOME/development/repositories/university"

# REPOSITORIES
alias djangorecipes="cd $HOME/development/repositories/sideprojects/django-recipes && source venv/bin/activate"
# alias reactrecipes="cd $HOME/development/repositories/sideprojects/react-recipes"
alias ucopuntomobile="cd $HOME/development/repositories/sideprojects/ucopunto-mobile"
alias practicesuco="cd $HOME/development/repositories/university/UCO-Practices"

# TEMPLATES
alias templatex="createLatexProjectFromName"
alias tskata="createTypescriptKataFromName"
alias pykata="createPythonKataFromName"

# VENV
alias venv="source venv/bin/activate"
alias new-venv="virtualenv -p python3 venv && source venv/bin/activate"

# OTHERS
alias ucossh="ssh -X i72rogup@ts.uco.es"
alias ec2ssh="connectToEC2InstanceFromIP"
alias ytdownload="youtube-dl -f best --restrict-filename -o '$HOME/Videos/%(title)s.%(ext)s'"
alias ytplaylist="youtube-dl -f best --restrict-filename -o '$HOME/Videos/%(playlist_index)s-%(title)s.%(ext)s'"
