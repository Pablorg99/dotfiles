#!/bin/bash

logFile="/tmp/log.txt"

showLoading() {
  myPid=$!
  loadingText=$1
  eraseToEndOfLine="\r\033[K"

  echo -ne "$loadingText\r"

  while kill -0 $myPid 2>/dev/null; do
    echo -ne "$loadingText.\r"
    sleep 0.5
    echo -ne "$loadingText..\r"
    sleep 0.5
    echo -ne "$loadingText...\r"
    sleep 0.5
    echo -ne "$eraseToEndOfLine"
    echo -ne "$loadingText\r"
    sleep 0.5
  done

  echo -e "$loadingText \e[1;32m\xE2\x9C\x94\e[0m"
}

updateAndUpgrade() {
  sudo apt-get update >> $logFile
  sudo apt-get upgrade >> $logFile
}

installGit() {
  sudo apt-get install -y git >> $logFile
}

installVim() {
  sudo apt-get install -y vim >> $logFile
}

installCurl() {
  sudo apt-get install -y curl >> $logFile
}

installZsh() {
  sudo apt-get install -y zsh >> $logFile
  sudo chsh -s /bin/zsh
}

installDocker() {
  sudo apt-get install -y apt-transport-https ca-certificates gnupg-agent software-properties-common >> $logFile
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - &>> $logFile
  sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" >> $logFile
  sudo apt-get update >> $logFile
  sudo apt-get install -y docker-ce docker-ce-cli containerd.io >> $logFile
  sudo usermod -aG docker $USER
}

installDockerCompose() {
  sudo curl -L "https://github.com/docker/compose/releases/download/1.25.3/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose &>> $logFile
  sudo chmod +x /usr/local/bin/docker-compose
}

installNode() {
  curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash - &>> $logFile
  sudo apt-get install -y nodejs >> $logFile
}

installYarn() {
  curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add - &>> $logFile
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list >> $logFile
  sudo apt-get update >> $logFile && sudo apt-get install -y yarn >> $logFile
}

installPip() {
  sudo apt-get install -y python-pip >> $logFile
  sudo apt-get install -y python3-pip >> $logFile
}

installVirtualenv() {
  pip3 install virtualenv >> $logFile
}

installTelegram() {
  wget https://telegram.org/dl/desktop/linux -O /tmp/telegram.tar.xz &>> $logFile
  tar -C /tmp/ -xvf /tmp/telegram.tar.xz >> $logFile
  sudo mv /tmp/Telegram /opt/
}

installFranz() {
  wget https://github.com/meetfranz/franz/releases/download/v5.4.0/franz_5.4.0_amd64.deb -O /tmp/franz.deb &>> $logFile
  sudo dpkg -i /tmp/franz.deb &>> $logFile
  sudo apt-get install -f >> $logFile
}

installSpotify() {
  curl -sS https://download.spotify.com/debian/pubkey.gpg | sudo apt-key add - &>> $logFile
  echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list >> $logFile
  sudo apt-get update >> $logFile && sudo apt-get install -y spotify-client-gnome-support >> $logFile
}

installMegaSync() {
  wget https://mega.nz/linux/MEGAsync/xUbuntu_18.04/amd64/megasync-xUbuntu_18.04_amd64.deb -o /tmp/megasync.deb &>> $logFile
  sudo dpkg -i /tmp/megasync.deb &>> $logFile
  sudo apt-get install -f >> $logFile
  wget https://mega.nz/linux/MEGAsync/xUbuntu_18.04/amd64/nautilus-megasync-xUbuntu_18.04_amd64.deb -o /tmp/megasync-nautilus-extension &>> $logFile
  sudo dpkg -i /tmp/megasync-nautilus-extension &>> $logFile
  sudo apt-get install -f >> $logFile
}

installTilda() {
  sudo apt-get install -y tilda >> $logFile
}

installVSCode() {
  wget https://go.microsoft.com/fwlink/?LinkID=760868 -o /tmp/vscode.deb &>> $logFile
  sudo dpkg -i /tmp/vscode.deb &>> $logFile
  sudo apt-get install -f >> $logFile
}

# BASIC PACKAGES
sudo ls . > $logFile
echo -e "INSTALLING BASIC PACKAGES"
updateAndUpgrade & showLoading "Updating and upgrading packages"
installGit & showLoading "Git"
installVim & showLoading "Vim"
installZsh & showLoading "Zsh"
installCurl & showLoading "Curl"
installDocker & showLoading "Docker"
installDockerCompose & showLoading "Docker-Compose"
installNode & showLoading "Node"
installYarn & showLoading "Yarn"
installPip & showLoading "Pip & Pip3"
installVirtualenv & showLoading "Virtualenv"
installTelegram & showLoading "Telegram"
installFranz & showLoading "Franz"
installSpotify & showLoading "Spotify"
installMegaSync & showLoading "MegaSync"
installTilda & showLoading "Tilda"
installVSCode & showLoading "VSCode"

# SSH KEY
echo "ADDING SSH KEY TO GITHUB"
rm -rf ~/.ssh/id_rsa ~/.ssh/id_rsa.pub
echo "Creating ssh key"
ssh-keygen -t rsa -b 4096
pub=$(cat ~/.ssh/id_rsa.pub)
read -p "Enter GitHub username: " githubuser
echo "Using username $githubuser"
read -s -p "Enter GitHub password for user $githubuser: " githubpass
curl -u "$githubuser:$githubpass" -X POST -d "{\"title\":\"`hostname`\",\"key\":\"$pub\"}" https://api.github.com/user/keys

installOhMyZsh() {
  wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O /tmp/install-oh-my-zsh.sh &>> $logFile
  bash /tmp/install-oh-my-zsh.sh --unattended >> $logFile
  # Installing xclip for copydir and copyfile extensions
  sudo apt-get install -y xclip >> $logFile
}

installFiraCode() {
  sudo apt-get install -y fonts-firacode >> $logFile
}

installTheFuck() {
  pip3 install thefuck >> $logFile
}

installNerdTree() {
  git clone https://github.com/scrooloose/nerdtree.git ~/.vim/pack/vendor/start/nerdtree >> $logFile
  vim -u NONE -c "helptags ~/.vim/pack/vendor/start/nerdtree/doc" -c q
}

# EXTENSIONS AND PLUGINS
echo "INSTALLING EXTENSIONS AND PLUGINS"
installOhMyZsh & showLoading "Oh My Zsh"
installFiraCode & showLoading "Fira Code"
installTheFuck & show Loading "TheFuck"
installNerdTree & showLoading "NerdTree"

cloneDotfiles() {
  git clone --recurse-submodules -j8 git@github.com:Pablorg99/dotfiles.git $HOME
}

developmentFolderStructure() {
  mkdir $HOME/development
  mkdir $HOME/development/devtools
  mkdir $HOME/development/repositories
  mkdir $HOME/development/repositories/sideprojects
  mkdir $HOME/development/repositories/codekatas
  mkdir $HOME/development/repositories/asl
  mkdir $HOME/development/repositories/university
}

cloneDjangoRecipes() {
  git clone git@github.com:Pablorg99/django-recipes.git $HOME/development/repositories/sideprojects >> $logFile
  virtualenv -p python3 $HOME/development/repositories/sideprojects/django-recipes/venv  >> $logFile
  source $HOME/development/repositories/sideprojects/django-recipes/venv/bin/activate >> $logFile
}

cloneUcoPuntoMobile() {
  git clone git@github.com:Pablorg99/ucopunto-mobile.git $HOME/development/repositories/sideprojects >> $logFile
}

cloneUcoPractices() {
  git clone git@github.com:Pablorg99/UCO-Practices.git $HOME/development/repositories/university >> $logFile
}

# CLONING REPOS
echo "REPOSITORIES AND DEVELOPMENT FOLDER STRUCTURE"
cloneDotfiles & showLoading "Dotfiles"
developmentFolderStructure & showLoading "'development' Folder Structure"
cloneDjangoRecipes & showLoading "Django Recipes"
cloneUcoPuntoMobile & showLoading "Uco Punto Mobile"
cloneUcoPractices & showLoading "Uco Practices"

# CREATE SOFT LINKS
zsh "$HOME/dotfiles/update.sh"
