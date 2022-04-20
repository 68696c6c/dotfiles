export PATH="/usr/local/opt/ruby/bin:$HOME/bin:$PATH"

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
CODE_DIR=$HOME/Code
alias ll='ls -lahG'
alias code='cd $CODE_DIR'
alias dot='cd $DOTFILES_DIR'
alias s0='cd $CODE_DIR/s0'
alias consumer='cd $CODE_DIR/app-consumer'
alias web='cd $CODE_DIR/webflow-components'
alias design='cd $CODE_DIR/design-system'

## AWS
alias ap="~/aws-profile.sh"
alias aconf='cat ~/.aws/config'
alias acreds='cat ~/.aws/credentials'
alias aprof='echo $AWS_PROFILE'
function ecs-tasks() {
  if [ $# != 3 ]; then
      echo "Usage: $0 ecs-task-def-name environment-name aws-profile-name"
      echo "Example: $0 app-operations-web staging staging_sso"
  fi
  ecs_task_def=$1
  aws_env=$2
  profile=$3
  aws ecs list-tasks --cluster $aws_env --service-name $ecs_task_def --profile $profile
}
function ecs-describe-task() {
  if [ $# != 3 ]; then
      echo "Usage: $0 task-id ecs-cluster-name aws-profile-name"
      echo "Example: $0 b8bae0f15fe145f29162cd9eb70557e7 staging staging_sso"
  fi
  task_id=$1
  aws_env=$2
  profile=$3
  aws ecs describe-tasks --cluster $aws_env --tasks $task_id --profile $profile
}
function ecs-console() {
  if [ $# != 3 ]; then
      echo "Usage: $0 ecs-task-def-name environment-name aws-profile-name"
      echo "Example: $0 app-operations-web staging staging_sso"
  fi
  ecs_task_def=$1
  aws_env=$2
  profile=$3
  aws ecs execute-command --profile $profile --cluster $aws_env --task `aws ecs list-tasks --cluster $aws_env --service-name $ecs_task_def --profile $profile | jq '.taskArns | last' | tr -d '"' | cut -d '/' -f3 ` --container $ecs_task_def --interactive --command "/bin/sh"
}

export EDITOR=rubymine

## DOCKER
alias dc='docker-compose'
alias dcr='docker-compose run --rm'
alias dcrp='docker-compose run --rm --service-ports'
alias dud='docker-compose up -d'
alias dps='docker ps'
alias drma='docker rm -f $(docker ps -aq)'
alias dnuke='docker volume prune && docker rmi -f $(docker images -q)'
alias dprune='docker volume prune'

## GIT
alias gs='git status'
function gco() {
  git checkout $1
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
  git pull --rebase $1 $2
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
#function cat() {
#    lolcat $1
#}

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

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
