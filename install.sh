#!/bin/bash

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

  echo -e "$loadingText \xE2\x9C\x94"
}

LOG_FILE="/tmp/log.txt"

updateAndUpgrade() {
  sudo apt-get update > $LOG_FILE && sudo apt-get upgrade >> $LOG_FILE
}

installGit() {
  sudo apt-get install git >> $LOG_FILE
}

installVim() {
  sudo apt-get install vim >> $LOG_FILE
}

installTelegram() {
  
}

# BASIC PACKAGES
updateAndUpgrade & showLoading "Updating and upgrading packages"
echo -e "\nINSTALLING BASIC PACKAGES"
installGit & showLoading "Git" 
installVim & showLoading "Vim"
installTelegram & showLoading "Telegram (/opt/Telegram)"
installFranz & showLoading "Franz"
installSpotify & showLoading "Spotify"
installVSCode & showLoading "VSCode"
# install git: sudo apt install git

# # ssh key git

# # install and setup zsh
# sudo apt install zsh
# sudo chsh -s /bin/zsh

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

# # install vim:
# sudo apt install vim

# # install nerdtree: 
# git clone https://github.com/scrooloose/nerdtree.git ~/.vim/pack/vendor/start/nerdtree
# vim -u NONE -c "helptags ~/.vim/pack/vendor/start/nerdtree/doc" -c q 

# # Execute update
# bash update.sh
