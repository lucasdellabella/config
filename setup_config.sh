#!/bin/bash
while [[ "$#" > 0 ]]; do case $1 in
  -r|--remote-deploy) remote=1;shift;;
  -u|--update-only) update=1;shift;;
  *) echo "Unknown parameter passed: $1"; exit 1;;
esac; done

if [[ -z $update ]]; then
    echo "$(tput setaf 3)Installing tools..."; tput sgr0
    if [[ -z $remote ]]; then
        brew list the_silver_searcher || brew install the_silver_searcher
        brew list fzf || brew install fzf
    fi

    echo "$(tput setaf 3)Installing tmux dependencies..."; tput sgr0
    if [[ -z $remote ]]; then
        brew list tmux || brew install tmux
    fi
    if [ ! -d "~/.tmux/plugins/tpm" ]; then
        git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    fi

    echo "$(tput setaf 3)Installing vim dependencies..."; tput sgr0
    if [ ! -d "~/.vim/colors/base16" ]; then
        git clone git://github.com/chriskempson/base16-vim.git ~/.vim/colors/base16
        cp ~/.vim/colors/base16/colors/*.vim ~/.vim/colors/
    fi

    if [ ! -d "~/.vim/bundle/" ]; then
        git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    fi
    vim +PluginInstall +Tmuxline +qall

    echo "$(tput setaf 3)Installing zsh dependencies..."; tput sgr0
    if [[ -z $remote ]]; then
        brew list zsh || brew install zsh
    fi
    if [ ! -d "~/.oh-my-zsh" ]; then
        git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
        chmod 744 ~/.oh-my-zsh/oh-my-zsh.sh
    fi
    if [ ! -d "~/.oh-my-zsh/plugins/zsh-autosuggestions" ]; then
        git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    fi
    if [ ! -d "~./oh-my-zsh/plugins/zsh-syntax-highlighting" ]; then
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

    fi
    mkdir -p ~/.oh-my-zsh/themes
fi


echo "$(tput setaf 3)Replacing existing config files..."; tput sgr0
cp .tmux.conf ~/.tmux.conf
cp .vimrc ~/.vimrc
cp .zshrc ~/.zshrc
cp .bash_profile ~/.bash_profile
cp jatin.zsh-theme ~/.oh-my-zsh/themes/jatin.zsh-theme


echo "$(tput setaf 3)Sourcing new configs..."; tput sgr0
source ~/.bash_profile
tmux source-file ~/.tmux.conf
if [[ ! $(echo $SHELL) = *"zsh"* ]]; then
    chsh -s /bin/zsh
    exec zsh
fi

if [[ -z $update ]]; then
    printf "$(tput setaf 2)Setup completed. To finish:\n 1) Manually apply iterm_colors.json.\n 2) Restart iterm.\n"
fi
