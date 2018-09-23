#!/usr/bin/bash

echo 'Installing tools...'
brew install the_silver_searcher
brew install fzf

echo 'Installing vim dependencies...'
if [ ! -d "~/.vim/bundle/" ]; then
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi
vim +PlugInstall +qall

echo 'Installing tmux dependencies...'
brew install tmux
if [ ! -d "~/.tmux/plugins/tpm" ]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi


echo 'Installing zsh dependencies...'
brew install zsh zsh-completions
sh -c '$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)'


echo 'Replacing existing config files...'
cp .tmux.conf ~/.tmux.conf
cp .vimrc ~/.vimrc
cp .zshrc ~/.zshrc
cp .bash_profile ~/.bash_profile
cp jatin.zsh-theme ~/.oh-my-zsh/themes/jatin.zsh-theme


echo 'Sourcing new configs...'
source ~/.bash_profile
source ~/.zshrc
tmux source-file ~/.tmux.conf

echo 'Setup completed successfuly. Make sure you manually apply the iterm coloscheme json!'
