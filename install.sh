#!/bin/bash

if [ $# -eq 1 ]; then
  logFile=$1
else
  echo "You need provide a path for the log file (e.g. './install /tmp/dotfilesInstallLog.txt')"
  exit 1
fi

############################
# DOING OPERATION FEEDBACK #
############################
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

#################
# SYSTEM UPDATE #
#################
systemUpdate() {
  sudo apt-get update &>> $logFile
  sudo apt-get upgrade -y &>> $logFile
  sudo apt-get autoremove -y &>> $logFile
  sudo apt-get autoclean &>> $logFile
}

#############################
# INSTALLING BASIC PACKAGES #
#############################
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
}

installDocker() {
  sudo apt-get install -y apt-transport-https ca-certificates gnupg-agent software-properties-common >> $logFile
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - &>> $logFile
  sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable" >> $logFile
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
  sudo apt-get update >> $logFile
  sudo apt-get install -y yarn >> $logFile
}

installLatex() {
  sudo apt-get install -y texlive-full &>> $logFile
}

installPip() {
  sudo apt-get install -y python-pip &>> $logFile
  sudo apt-get install -y python3-pip &>> $logFile
}

installVirtualenv() {
  sudo apt-get install -y virtualenv >> $logFile
}

installPoetry() {
  curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python >> $logFile
  chmod ug+x $HOME/.poetry/env
  source $HOME/.poetry/env
}

installFlutter() {
  git clone https://github.com/flutter/flutter.git -b stable $HOME/development/devtools/flutter-sdk &>> $logFile
}

installPhp() {
  sudo add-apt-repository ppa:ondrej/php -y &>> $logFile
  sudo apt-get update &>> $logFile
  sudo apt-get install -y php &>> $logFile
}

installSymfony() {
  wget https://get.symfony.com/cli/installer -O - | bash &>> $logFile
}

installOpenJDKs() {
  sudo apt-get install -y openjdk-8-jdk >> $logFile
  sudo apt-get install -y openjdk-11-jdk >> $logFile
}

installYouTubeDL() {
  sudo curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl
  sudo chmod a+rx /usr/local/bin/youtube-dl
}


installTelegram() {
  wget https://telegram.org/dl/desktop/linux -O /tmp/telegram.tar.xz &>> $logFile
  tar -C /tmp/ -xvf /tmp/telegram.tar.xz >> $logFile
  if [ ! -d /opt/Telegram ]; then
    sudo mv /tmp/Telegram /opt/
  fi
}

installFranz() {
  wget https://github.com/meetfranz/franz/releases/download/v5.4.0/franz_5.4.0_amd64.deb -O /tmp/franz.deb &>> $logFile
  sudo dpkg -i /tmp/franz.deb &>> $logFile
  sudo apt-get install -f -y >> $logFile
}

installSpotify() {
  curl -sS https://download.spotify.com/debian/pubkey.gpg | sudo apt-key add - &>> $logFile
  echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list >> $logFile
  sudo apt-get update >> $logFile
  sudo apt-get install -y spotify-client-gnome-support >> $logFile
}

installMegaSync() {
  wget https://mega.nz/linux/MEGAsync/xUbuntu_18.04/amd64/megasync-xUbuntu_18.04_amd64.deb -O /tmp/megasync.deb &>> $logFile
  sudo dpkg -i /tmp/megasync.deb &>> $logFile
  sudo apt-get install -f -y >> $logFile
  wget https://mega.nz/linux/MEGAsync/xUbuntu_18.04/amd64/nautilus-megasync-xUbuntu_18.04_amd64.deb -O /tmp/megasync-nautilus-extension &>> $logFile
  sudo dpkg -i /tmp/megasync-nautilus-extension &>> $logFile
  sudo apt-get install -f -y >> $logFile
}

installDropbox() {
  wget https://www.dropbox.com/download?dl=packages/ubuntu/dropbox_2020.03.04_amd64.deb -O /tmp/dropbox.deb &>> $logFile
  sudo dpkg -i /tmp/dropbox.deb &>> $logFile
  sudo apt-get install -f -y >> $logFile
}

installVSCode() {
  wget https://go.microsoft.com/fwlink/?LinkID=760868 -O /tmp/vscode.deb &>> $logFile
  sudo dpkg -i /tmp/vscode.deb &>> $logFile
  sudo apt-get install -f -y >> $logFile
}

installJetBrainsToolBox() {
  wget https://download.jetbrains.com/toolbox/jetbrains-toolbox-1.16.6319.tar.gz -O /tmp/jetbrains-toolbox.tar.gz &>> $logFile
  tar -C /tmp/ -zxvf /tmp/jetbrains-toolbox.tar.gz >> $logFile
  if [ ! -f /usr/local/bin/jetbrains-toolbox-1.16.6319 ]; then
    sudo mv /tmp/jetbrains-toolbox-1.16.6319/jetbrains-toolbox /usr/local/bin
  fi
}

installTilda() {
  sudo apt-get install -y tilda >> $logFile
}

##########################
# EXTENSIONS AND PLUGINS #
##########################
installOhMyZsh() {
  wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O /tmp/install-oh-my-zsh.sh &>> $logFile
  bash /tmp/install-oh-my-zsh.sh --unattended &>> $logFile
  # Installing xclip for copydir and copyfile extensions
  sudo apt-get install -y xclip >> $logFile
}

installTheFuck() {
  sudo apt-get install -y python3-dev python3-pip python3-setuptools >> $logFile
  sudo -H pip3 install thefuck >> $logFile
}

installNerdTree() {
  git clone https://github.com/scrooloose/nerdtree.git ~/.vim/pack/vendor/start/nerdtree &>> $logFile
  vim -u NONE -c "helptags ~/.vim/pack/vendor/start/nerdtree/doc" -c q &>> $logFile
}

installFiraCode() {
  sudo apt-get install -y fonts-firacode >> $logFile
}

installAdapta() {
  sudo add-apt-repository ppa:tista/adapta -y &>> $logFile
  sudo apt-get update &>> $logFile
  sudo apt-get install -y adapta-gtk-theme &>> $logFile
}

installPapirus() {
  sudo add-apt-repository ppa:papirus/papirus -y &>> $logFile
  sudo apt-get update &>> $logFile
  sudo apt-get install -y papirus-icon-theme &>> $logFile
}

################################
# DEVELOPMENT FOLDER STRUCTURE #
################################
developmentFolderStructure() {
  mkdir -p $HOME/development
  mkdir -p $HOME/development/devtools
  mkdir -p $HOME/development/repositories
  mkdir -p $HOME/development/repositories/sideprojects
  mkdir -p $HOME/development/repositories/codekatas
  mkdir -p $HOME/development/repositories/asl
  mkdir -p $HOME/development/repositories/university
}

########################
# CLONING REPOSITORIES #
########################
cloneDotfiles() {
  git clone --recurse-submodules -j8 git@github.com:Pablorg99/dotfiles.git $HOME/dotfiles &>> $logFile
}

cloneDjangoRecipes() {
  git clone git@github.com:Pablorg99/django-recipes.git $HOME/development/repositories/sideprojects/django-recipes &>> $logFile
  virtualenv -p python3 venv >> $logFile
}

cloneUcoPuntoMobile() {
  git clone git@github.com:Pablorg99/ucopunto-mobile.git $HOME/development/repositories/sideprojects/ucopunto-mobile &>> $logFile
}

cloneUcoPractices() {
  git clone git@github.com:Pablorg99/UCO-Practices.git $HOME/development/repositories/university/UCO-Practices &>> $logFile
}

# ASK SUDO PASSWORD
sudo ls . > $logFile

# SYSTEM UPDATE
systemUpdate & showLoading "SYSTEM UPDATE"

# INSTALLING BASIC PACKAGES
echo -e "INSTALLING BASIC PACKAGES"
installGit & showLoading "Git"
installVim & showLoading "Vim"
installZsh & showLoading "Zsh"
installCurl & showLoading "Curl"
installDocker & showLoading "Docker"
installDockerCompose & showLoading "Docker-Compose"
installNode & showLoading "Node"
installYarn & showLoading "Yarn"
installLatex & showLoading "LaTeX"
installPip & showLoading "Pip"
installVirtualenv & showLoading "Virtualenv"
installPoetry & showLoading "Poetry"
installFlutter & showLoading "Flutter"
installPhp & showLoading "Php"
installSymfony & showLoading "Symfony"
installOpenJDKs & showLoading "OpenJDKs"
installYouTubeDL & showLoading "YouTube-DL"
installTelegram & showLoading "Telegram"
installFranz & showLoading "Franz"
installSpotify & showLoading "Spotify"
installMegaSync & showLoading "MegaSync"
installDropbox & showLoading "Dropbox"
installVSCode & showLoading "VSCode"
installJetBrainsToolBox & showLoading "JetBrains ToolBox"
installTilda & showLoading "Tilda"

# ADDING SSH KEY TO GITHUB
echo "ADDING SSH KEY TO GITHUB"
rm -rf ~/.ssh/id_rsa ~/.ssh/id_rsa.pub
ssh-keygen -t rsa -b 4096
sshKey=$(cat ~/.ssh/id_rsa.pub)
read -s -p "Enter a personal acces token token with 'write:public_key' scope (https://github.com/settings/tokens): " githubToken
curl -i --header "Authorization: token $githubToken" --data "{\"title\": \"$(hostname)\", \"key\": \"$sshKey\"}" https://api.github.com/user/keys &>> $logFile
echo -ne "\n"
yes | ssh -T git@github.com >> $logFile

# THEMES AND EXTENSIONS
echo "INSTALLING EXTENSIONS AND PLUGINS"
installOhMyZsh & showLoading "Oh My Zsh"
installTheFuck & showLoading "TheFuck"
installNerdTree & showLoading "NerdTree"
installFiraCode & showLoading "Fira Code"
installAdapta & showLoading "Adapta"
installPapirus & showLoading "Papirus"

# DEVELOPMENT FOLDER STRUCTURE
developmentFolderStructure & showLoading "DEVELOPMENT FOLDER STRUCTURE"

# CLONING REPOSITORIES
echo "CLONING REPOSITORIES"
cloneDotfiles & showLoading "Dotfiles"
cloneDjangoRecipes & showLoading "Django Recipes"
cloneUcoPuntoMobile & showLoading "Uco Punto Mobile"
cloneUcoPractices & showLoading "Uco Practices"

# SHELL CONFIGURATION
sudo chsh -s /bin/zsh $USER
zsh "$HOME/dotfiles/update.sh"
exec zsh
