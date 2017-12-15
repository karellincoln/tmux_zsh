#! /bin/bash

yum install -y zsh tmux

mkdir -p ~/.oh-my-zsh
/bin/cp -rf oh-my-zsh/* ~/.oh-my-zsh/
/bin/cp -f oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
chsh -s /usr/bin/zsh


/bin/cp -f tmux.conf ~/.tmux.conf
