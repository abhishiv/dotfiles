#!/usr/bin/env bash

pip3 install neovim
npm install -g neovim
npm install -g spaceship-prompt
pip3 install vim-vint
npm i -g bash-language-server
gem install colorls
brew tap homebrew/cask-fonts
brew cask install font-hack-nerd-font
mkdir -p ~/.local/share/nvim/backup
npm install -g vtop

source install/backup.sh
source install/link.sh

nvim +PlugInstall +qall
nvim +UpdateRemotePlugins +qall
cp ~/.config/nvim/space.vim ~/.config/nvim/plugged/vim-airline-themes/autoload/airline/themes/space.vim

#ln -s ./.spacemacs ~/.spacemacs
