#!/bin/bash

LOG_FILE="/tmp/log.txt"

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
  sudo apt-get update >> $LOG_FILE
  sudo apt-get upgrade >> $LOG_FILE
}

installGit() {
  sudo apt-get install -y git >> $LOG_FILE
}

installVim() {
  sudo apt-get install -y vim >> $LOG_FILE
}

installCurl() {
  sudo apt-get install -y curl >> $LOG_FILE
}

installZsh() {
  sudo apt-get install -y zsh >> $LOG_FILE
  sudo chsh -s /bin/zsh
}

installDocker() {
  sudo apt-get install -y apt-transport-https ca-certificates gnupg-agent software-properties-common >> $LOG_FILE
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - &>> $LOG_FILE
  sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" >> $LOG_FILE
  sudo apt-get update >> $LOG_FILE
  sudo apt-get install -y docker-ce docker-ce-cli containerd.io >> $LOG_FILE
  sudo usermod -aG docker $USER
}

installDockerCompose() {
  sudo curl -L "https://github.com/docker/compose/releases/download/1.25.3/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose &>> $LOG_FILE
  sudo chmod +x /usr/local/bin/docker-compose
}

installNode() {
  curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash - &>> $LOG_FILE
  sudo apt-get install -y nodejs >> $LOG_FILE
}

installYarn() {
  curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add - &>> $LOG_FILE
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list >> $LOG_FILE
  sudo apt-get update >> $LOG_FILE && sudo apt-get install -y yarn >> $LOG_FILE
}

installPip() {
  sudo apt-get install -y python-pip >> $LOG_FILE
  sudo apt-get install -y python3-pip >> $LOG_FILE
}

installVirtualenv() {
  pip3 install virtualenv >> $LOG_FILE
}

installTelegram() {
  wget https://telegram.org/dl/desktop/linux -O /tmp/telegram.tar.xz &>> $LOG_FILE
  tar -C /tmp/ -xvf /tmp/telegram.tar.xz >> $LOG_FILE
  sudo mv /tmp/Telegram /opt/
}

installFranz() {
  wget https://github.com/meetfranz/franz/releases/download/v5.4.0/franz_5.4.0_amd64.deb -O /tmp/franz.deb &>> $LOG_FILE
  sudo dpkg -i /tmp/franz.deb &>> $LOG_FILE
  sudo apt-get install -f >> $LOG_FILE
}

installSpotify() {
  curl -sS https://download.spotify.com/debian/pubkey.gpg | sudo apt-key add - &>> $LOG_FILE
  echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list >> $LOG_FILE
  sudo apt-get update >> $LOG_FILE && sudo apt-get install -y spotify-client-gnome-support >> $LOG_FILE
}

installMegaSync() {
  wget https://mega.nz/linux/MEGAsync/xUbuntu_18.04/amd64/megasync-xUbuntu_18.04_amd64.deb -o /tmp/megasync.deb &>> $LOG_FILE
  sudo dpkg -i /tmp/megasync.deb &>> $LOG_FILE
  sudo apt-get install -f >> $LOG_FILE
  wget https://mega.nz/linux/MEGAsync/xUbuntu_18.04/amd64/nautilus-megasync-xUbuntu_18.04_amd64.deb -o /tmp/megasync-nautilus-extension &>> $LOG_FILE
  sudo dpkg -i /tmp/megasync-nautilus-extension &>> $LOG_FILE
  sudo apt-get install -f >> $LOG_FILE
}

installTilda() {
  sudo apt-get install -y tilda >> $LOG_FILE
}

installVSCode() {
  wget https://go.microsoft.com/fwlink/?LinkID=760868 -o /tmp/vscode.deb &>> $LOG_FILE
  sudo dpkg -i /tmp/vscode.deb &>> $LOG_FILE
  sudo apt-get install -f >> $LOG_FILE
}

# BASIC PACKAGES
sudo ls . > $LOG_FILE
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

# # ssh key git

# # install oh-my-zsh:
# sudo apt install curl
# sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# # install fira code:
# sudo apt install fonts-firacode

# # install xclip for extensions:
# sudo apt install xclip

# # install thefuck:
# sudo apt install python3-dev python3-pip python3-setuptools
# sudo pip3 install thefuck

# # install nerdtree:
# git clone https://github.com/scrooloose/nerdtree.git ~/.vim/pack/vendor/start/nerdtree
# vim -u NONE -c "helptags ~/.vim/pack/vendor/start/nerdtree/doc" -c q

# # Execute update
zsh "$HOME/dotfiles/update.sh"
