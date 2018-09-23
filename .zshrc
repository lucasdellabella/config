export ZSH="/nail/home/jatin/.oh-my-zsh"

ZSH_THEME="jatin"
bindkey jk vi-cmd-mode

plugins=(
  git
  zsh-syntax-highlighting
  warhol
  zsh-autosuggestions
  extract
)

source $ZSH/oh-my-zsh.sh

if [ "$TMUX" ]; then
    PROMPT_COMMAND='eval "$(/nail/scripts/tmux-env)"; '"$PROMPT_COMMAND"
fi

# cd does ls
chpwd() {
  ls
}

# opens file from name in vim regardless of path
 vf() {
     find . -name "$1" -not -path "./node_modules/*" -exec vim {} +
 }

# runs pytests from name regardless of path
 ptf() {
     find . -name "$1" -not -path "./node_modules/*" | xargs pytest
 }

# runs python from name regardless of path
 pyf() {
     find . -name "$1" -not -path "./node_modules/*" | xargs python
 }

# find files from name
 f() {
     find . -name "$1" -not -path "./node_modules/*"
 }

# unix timestamp conversion
dt() {
    date -d "@$1"
}

# cd to a directory 2 levels deep from root
cdf() {
    result=$(print -l ~/pg/*/*(/) | fzf)
    if [ ! -z "$result" ]; then
        cd $result
    fi
}

# search and replace
sr() {
    grep -rl "$1" ./ | xargs sed -i "s/$1/$2/g"
}


# clone a yelp repo
 clone() {
     result=$(git yelp-list-repos | fzf)
     if [ ! -z "$result" ]; then
        git clone $result
     fi
 }

# checkout branch
co() {
    if [ ! -z "$1" ]; then
        git checkout "$1"
    else
        branch=$(git branch | fzf | rev | cut -d ' ' -f -1 | rev)
        if [ ! -z "$branch" ]; then
            git checkout $branch
        fi
    fi
}

# pull feature branch onto this one
gpf() {
    if [ ! -z "$1" ]; then
        git pull . "$1"
    else
        branch=$(git branch | fzf | rev | cut -d ' ' -f -1 | rev)
        if [ ! -z "$branch" ]; then
            git pull . $branch
        fi
    fi
}

# merge feature to master
gfm() {
    branch=$(git branch | grep '^*' | sed 's/* //'  )
    if [ "$branch" != "master" ]; then
        git fetch origin master:master
        git rebase origin master
        git checkout master
        git reset --hard origin/master
        git pull . $branch --no-ff
    fi
}

# reset to master
grm() {
    git fetch
    git reset --hard origin/master
}

# cd to git project root
cdr() {
    cd "$(git rev-parse --show-toplevel)"
}

# look at files in last n commit's diff (defaults to last diff)
vd() {
    file=$(git diff HEAD~${1:-1} --name-only | fzf)
    if [ ! -z "$file" ]; then
        vim $file
    fi
}

# git diff last n commits (defaults to last commit)
gdh() {
    git diff HEAD~${1:-1}
}


alias fzf="fzf --color fg:242,bg:233,hl:65,fg+:15,bg+:234,hl+:108 --color info:108,prompt:109,spinner:108,pointer:168,marker:168"
alias rb="review-branch"

# re-source dots
alias sz="source ~/.zshrc"
alias st="tmux source-file ~/.tmux.conf"
alias z="vim ~/.zshrc"
alias t="vim ~/.tmux.conf"
alias v="vim ~/.vimrc"
