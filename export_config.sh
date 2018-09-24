#!/usr/bin/bash
cp ~/.tmux.conf .
cp ~/.vimrc .
cp ~/.zshrc .
cp ~/.bash_profile .
cp ~/.oh-my-zsh/themes/jatin.zsh-theme .
git add .
git commit -m "updating dot files"
