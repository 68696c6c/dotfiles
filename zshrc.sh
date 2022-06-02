DOTFILES_DIR=~/Code/dotfiles

export ZSH_THEME=agnoster

# ZGEN
# https://github.com/tarjoilija/zgen
source $DOTFILES_DIR/zgen/zgen.zsh
if ! zgen saved; then
  zgen oh-my-zsh
  zgen oh-my-zsh agnoster
  zgen save
fi

# Hide the user@host in the shell prompt.
export DEFAULT_USER=aaron.hill
prompt_context(){
  true
}


## PROFILE
alias szp='source ~/.zshrc'
alias hosts='sudo nano /etc/hosts'

## NAVIGATION
alias ll='ls -lahG'
alias code='cd $HOME/Code'
alias cdgo='cd $HOME/Code/Go/src'
alias cdpy='cd $HOME/Code/Python'
alias dot='cd $DOTFILES_DIR'

## DOCKER
alias dc='docker-compose'
alias dr='docker-compose run --rm'
alias drp='docker-compose run --rm --service-ports'
alias dud='docker-compose up -d'
alias dps='docker ps'
alias drma='docker rm -f $(docker ps -aq)'
alias dnuke='docker volume prune && docker rmi -f $(docker images -q)'

## GIT
alias gs='git status'
function gco() {
  git checkout $1 $2
}
function gcb() {
  git checkout -b $1
}
function gcm() {
  git commit -m $1
}
function gp() {
  git pull $1
}
function gpr() {
  git pull --rebase $1
}
function gap() {
  git add -p
}
function gu() {
  git reset --soft HEAD~1
}
function gri() {
  git rebase -i HEAD~$1
}

## SYSTEM

# List processes using the specified port.
function port() {
  sudo lsof -i tcp:$1
}

# List files sorted by size.
function dush() {
  du -h -d 1 . | sort -n -r | head -n 10
}

## NODE
function n() {
  brew unlink node
  brew link node@$1 --force --overwrite
}

## YARN
alias y='yarn'
alias yd='yarn develop'
alias yt='yarn test'

## LOLCAT
alias lll='ll | lolcat'
function cat() {
    lolcat $1
}

## GO
export GOPATH=$HOME/Code/Go
alias gpath='echo $GOPATH'

## PHP
alias artisan='php artisan'
alias phpunit='vendor/bin/phpunit'

## Python
# Run pip inside the python:latest docker image.
alias python='python3'
alias pip='docker run --rm -it -v $PWD:$PWD --workdir $PWD python:latest pip'

## RUBY
# Add rbenv to bash so that it loads every time you open a terminal
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
