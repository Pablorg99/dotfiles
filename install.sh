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
  greenCheck="\e[1;32m\xE2\x9C\x94\e[0m"

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

  echo -e "$loadingText $greenCheck"
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
  sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" >> $logFile
  sudo apt-get update >> $logFile
  sudo apt-get install -y docker-ce docker-ce-cli containerd.io >> $logFile
  sudo usermod -aG docker $USER
}

installDockerCompose() {
  sudo curl -L "https://github.com/docker/compose/releases/download/1.25.3/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose &>> $logFile
  sudo chmod +x /usr/local/bin/docker-compose
}

installNvm() {
  wget -qO - https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash &>> $logFile
}

installYarn() {
  curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add - &>> $logFile
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list >> $logFile
  sudo apt-get update >> $logFile
  sudo apt-get install -y yarn >> $logFile
}

installLatex() {
  sudo apt-get install -y texlive &>> $logFile
}

installPip() {
  sudo apt-get install -y python-pip &>> $logFile
  sudo apt-get install -y python3-pip &>> $logFile
}

installVirtualenv() {
  sudo apt-get install -y virtualenv >> $logFile
}

installFlutter() {
  git clone https://github.com/flutter/flutter.git -b stable $HOME/development/devtools/flutter-sdk &>> $logFile
}

installPhp() {
  sudo add-apt-repository ppa:ondrej/php -y &>> $logFile
  sudo apt-get update &>> $logFile
  sudo apt-get install -y php php-xml php-curl &>> $logFile
}

installComposer() {
  sudo apt-get install -y php-cli php-mbstring &>> $logFile
  sudo curl -s https://getcomposer.org/installer | php &>> $logFile
  sudo mv composer.phar /usr/local/bin/composer
}

installSymfony() {
  wget -q https://get.symfony.com/cli/installer -O - | bash &>> $logFile
}

installOpenJDKs() {
  sudo apt-get install -y openjdk-8-jdk >> $logFile
  sudo apt-get install -y openjdk-11-jdk >> $logFile
}

installYouTubeDL() {
  sudo curl -sL https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl
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
  megaUrl=https://mega.nz/linux/MEGAsync/xUbuntu_$(lsb_release -sr)/amd64
  wget $megaUrl/megasync-xUbuntu_$(lsb_release -sr)_amd64.deb -O /tmp/megasync.deb &>> $logFile
  sudo dpkg -i /tmp/megasync.deb &>> $logFile
  sudo apt-get install -f -y >> $logFile
  wget $megaUrl/nautilus-megasync-xUbuntu_$(lsb_release -sr)_amd64.deb -O /tmp/megasync-extension.deb &>> $logFile
  sudo dpkg -i /tmp/megasync-extension.deb &>> $logFile
  sudo apt-get install -f -y >> $logFile
}

installTilda() {
  sudo apt-get install -y tilda >> $logFile
}

installDropbox() {
  wget https://www.dropbox.com/download?dl=packages/ubuntu/dropbox_2020.03.04_amd64.deb -O /tmp/dropbox.deb &>> $logFile
  sudo dpkg -i /tmp/dropbox.deb &>> $logFile
  sudo apt-get install -f -y >> $logFile
}

installBirdtray() {
  sudo apt-get install -y qt5-default libqt5x11extras5-dev qttools5-dev libqt5svg5-dev libx11-xcb-dev cmake x11extras-dev &>> $logFile
  wget https://github.com/gyunaev/birdtray/archive/master.zip -O /tmp/birdtray.zip &>> $logFile
  unzip /tmp/birdtray.zip -d /tmp/ &>> $logFile
  mkdir -p /tmp/birdtray-master/build
  cd /tmp/birdtray-master/build
  cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/opt/birdtray .. &>> $logFile
  sudo cmake --build . --target install &>> $logFile
  cd $HOME
}

installVSCode() {
  wget https://go.microsoft.com/fwlink/?LinkID=760868 -O /tmp/vscode.deb &>> $logFile
  sudo dpkg -i /tmp/vscode.deb &>> $logFile
  sudo apt-get install -f -y >> $logFile
}

installDiscord() {
	wget -O /tmp/discord.deb https://discordapp.com/api/download?platform=linux&format=deb &>> $logfile
	sudo dpkg -i /tmp/discord.deb &>> $logFile
	sudo apt-get install -f -y >> $logFile
}

installJetBrainsToolBox() {
  wget https://download.jetbrains.com/toolbox/jetbrains-toolbox-1.16.6319.tar.gz -O /tmp/jetbrains-toolbox.tar.gz &>> $logFile
  tar -C /tmp/ -zxvf /tmp/jetbrains-toolbox.tar.gz >> $logFile
  if [ ! -f /usr/local/bin/jetbrains-toolbox-1.16.6319 ]; then
    sudo mv /tmp/jetbrains-toolbox-1.16.6319/jetbrains-toolbox /usr/local/bin
  fi
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

installPapirus() {
  sudo add-apt-repository ppa:papirus/papirus -y &>> $logFile
  sudo apt-get update &>> $logFile
  sudo apt-get install -y papirus-icon-theme &>> $logFile
}

installPaper() {
  sudo add-apt-repository -u ppa:snwh/ppa -y &>> $logFile
  sudo apt-get update &>> $logFile
  sudo apt install -y paper-icon-theme &>> $logFile
}

createNewSshKey() {
  rm -rf ~/.ssh/id_rsa ~/.ssh/id_rsa.pub
  ssh-keygen -t rsa -b 4096
  sshKey=$(cat ~/.ssh/id_rsa.pub)
  read -s -p "Enter a personal acces token token with 'write:public_key' scope (https://github.com/settings/tokens): " githubToken
  curl -i --header "Authorization: token $githubToken" --data "{\"title\": \"$(hostname)\", \"key\": \"$sshKey\"}" https://api.github.com/user/keys &>> $logFile
  echo
  yes | ssh -T git@github.com >> $logFile
}

##########
# OTHERS #
##########
developmentFolderStructure() {
  mkdir -p $HOME/development
  mkdir -p $HOME/development/devtools
  mkdir -p $HOME/development/repositories
  mkdir -p $HOME/development/repositories/sideprojects
  mkdir -p $HOME/development/repositories/codekatas
  mkdir -p $HOME/development/repositories/asl
  mkdir -p $HOME/development/repositories/university
}

cloneDotfiles() {
  git clone --recurse-submodules -j8 git@github.com:Pablorg99/dotfiles.git $HOME/dotfiles &>> $logFile
}

createShortcuts() {
  sudo ln -sfn $HOME/dotfiles/shortcuts/birdtray.desktop /usr/share/applications/birdtray.desktop
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
installNvm & showLoading "Nvm"
installYarn & showLoading "Yarn"
installLatex & showLoading "LaTeX"
installPip & showLoading "Pip"
installVirtualenv & showLoading "Virtualenv"
installFlutter & showLoading "Flutter"
installPhp & showLoading "Php"
installComposer & showLoading "Composer"
installSymfony & showLoading "Symfony"
installOpenJDKs & showLoading "OpenJDKs"
installYouTubeDL & showLoading "YouTube-DL"
installTelegram & showLoading "Telegram"
installFranz & showLoading "Franz"
installSpotify & showLoading "Spotify"
installMegaSync & showLoading "MegaSync"
installTilda & showLoading "Tilda"
installBirdtray & showLoading "Birdtray"
installVSCode & showLoading "VSCode"
installDiscord & showLoading "Discord"
installDropbox & showLoading "Dropbox"
installJetBrainsToolBox & showLoading "JetBrains ToolBox"

# ADDING SSH KEY TO GITHUB
echo "SSH KEY FOR GITHUB"
read -p "Dou you want to create a ssh key and link it to GitHub? [y/N] " -n 1
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
  createNewSshKey
fi

# THEMES AND EXTENSIONS
echo "INSTALLING EXTENSIONS AND PLUGINS"
installOhMyZsh & showLoading "Oh My Zsh"
installTheFuck & showLoading "TheFuck"
installNerdTree & showLoading "NerdTree"
installFiraCode & showLoading "Fira Code"
installPapirus & showLoading "Papirus Icons"
# ppa without support for focal lts
# installPaper & showLoading "Paper Icons"

# DEVELOPMENT FOLDER STRUCTURE AND DOTFILES
echo "OTHERS"
developmentFolderStructure & showLoading "Development Folder"
cloneDotfiles & showLoading "Cloning Dotfiles"
createShortcuts & showLoading "Shortcuts"

# SHELL CONFIGURATION
sudo chsh -s /bin/zsh $USER
zsh "$HOME/dotfiles/update.sh"
exec zsh
