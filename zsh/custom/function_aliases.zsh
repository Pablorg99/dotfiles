createLatexProjectFromName() {
    if [[ $# -eq 1 ]]; then
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
    if [[ $# -eq 1 ]]; then
        mkdir $1
        cd $1
        cp -r $HOME/dotfiles/templates/typescript-kata-template/. $(pwd)
        rm -rf .git
        sed -i "s/Kata/$1/g" src/Kata.ts
        sed -i "s/Kata/$1/g" test/Kata.spec.ts
        mv src/Kata.ts src/"$1".ts
        mv test/Kata.spec.ts test/"$1".spec.ts
        nvm use
        yarn install
        code $(pwd)
    else
        echo "Correct usage: tskata <kata_name>"
    fi
}

createPythonKataFromName() {
    if [[ $# -eq 1 ]]; then
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
    if [[ $# -eq 1 ]]; then
        ssh ec2-user@"$1" -i $HOME/MEGA/Universidad/Tercero/Otros/AWS/PrivateKeyEC2.pem
    else
        echo "Correct usage: ec2ssh <instance_public_ip>"
    fi
}
