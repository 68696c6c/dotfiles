export PATH="$(brew --prefix php)/bin:$PATH"


################################################################################
### SYSTEM

function phelp() {
    echo 'Available commands'
    echo ''
    echo 'Profile'
    echo '  bp          edit .bash_profile'
    echo '  sbp         reload .bash_profile'
    echo '  bbp         backup ~/.bash_profile to ~/.bash_profile-(timestamp)'
    echo '  dbp         backup ~/.bash_profile and replace it with ~/Code/_dev/bash_profile.sh'
    echo ''
    echo 'Utils'
    echo '  hosts       edit /etc/hosts'
    echo '  dh          edit /etc/hosts'
    echo '  new         create new empty Code project'
    echo '  port        show which processes are using the specified port'
    echo '  dush        show top 10 largest files in current directory'
    echo '  calnag      fix iCal to not fucking steal focus'
    echo ''
    echo 'Navigation'
    echo '  ll          ls -lahG'
    echo '  code        navigate to project root dir'
    echo '  dev         navigate to the _dev project'
    echo '  cdgo        navigate to GOPATH/src'
    echo '  cdpy        navigate to Python project root'
    echo ''
    echo 'AWS'
    echo '  aa        run ~/aws-account.sh'
    echo '  ap        run ~/aws-profile.sh'
    echo '  acreds    print ~/.aws/credentials'
    echo ''
    echo 'Docker'
    echo '  dc          docker-compose'
    echo '  dr          docker-compose run --rm'
    echo '  drp         docker-compose run --rm --service-ports'
    echo '  dud         docker-compose up -d'
    echo '  dps         docker ps'
    echo '  drma        kill all running docker services: docker rm -f $(docker ps -aq)'
    echo '  dnuke       delete all images and prune all volumes'
    echo ''
    echo 'Make'
    echo '  mi          make image'
    echo '  ml          make local'
    echo '  md          make deps'
    echo '  mt          make test'
    echo ''
    echo 'Git'
    echo '  gs          git status'
    echo '  gco         git checkout $branch-name'
    echo '  gcb         git checkout -b $branch-name'
    echo '  gcm         git commit -m $message'
    echo '  gp          git pull origin $branch-name'
    echo '  gpr         git pull --rebase origin $branch-name'
    echo '  gap         git add -p'
    echo '  gu          git reset --soft HEAD~1 (undo commit)'
    echo ''
    echo 'Node & Yarn'
    echo '  n $version   switch Node version using Brew'
    echo '  y            run yarn'
    echo '  yd           yarn develop'
    echo '  yt           yarn test'
    echo ''
    echo 'Projects'
    echo '  goat        navigate to the goat project dir'
    echo '  horns       navigate to the horns project dir'
    echo '  kedge       navigate to $project: dock, api, web, db, deploy, web1, shopify'
    echo '  loom        navigate to loom project dir'
    echo '  lesh        navigate to leshen project dir'
    echo '  usdish      navigate to usdish project dir'
    echo '  cldock      navigate to martech-docker project dir'
    echo ''
    echo 'Languages'
    echo '  gpath       echo $GOPATH'
    echo '  artisan     php artisan $command'
    echo '  phpunit     vendor/bin/phpunit'
    echo '  python      python3'
    echo '  pip         run pip inside of a python:latest docker container'
    echo ''
    echo 'Fun'
    echo '  lolcat      rainbowify console output!'
    echo '  lll         fabulous ll!'
    echo '  cat         reading rainbow!'
    echo '  m           make $target, but more fun!'
    echo '  cowsay      moo!'
    echo '  fortune     console-t the oracle!'
    echo '  lol         gay psychic bovine!'
    echo '  fuck        make a swear!'
    echo ''
}

function p() {
    phelp | lolcat
}

function new() {
    mkdir -p "$(dirname "$HOME/Code/$1")" || return; touch "$HOME/Code/$1/docker-compose.yml";
}

# List processes using the specified port.
function port() {
    sudo lsof -i tcp:$1
}

function dush() {
  du -h -d 1 . | sort -n -r | head -n 10
}

## AWS
# legacy aws-profile switcher
#alias aa="export AWS_EMAIL=$(~/aws-account.sh)"
alias aws='docker run --rm -it -v ~/.aws:/root/.aws amazon/aws-cli --profile=$AWS_PROFILE'
alias ap="~/aws-profile.sh"
alias aconf='cat ~/.aws/config'
alias acreds='cat ~/.aws/credentials'
alias aprof='echo $AWS_PROFILE'
#alias kprod='export AWS_PROFILE=kedge-production'
#alias cldev='export AWS_PROFILE=martech-developer'
#alias clprod='export AWS_PROFILE=martech-prod'
#alias awsgoat='export AWS_PROFILE=goat'
#alias gprod='export AWS_PROFILE=goat-production'

# Fucking iCal is fucking broken and steals focus when a new event is received. Garbage status broken ass shit UI.
alias calnag="defaults write com.apple.iCal NSDontMakeMainWindowKey YES"

## PROFILE
alias bp='nano ~/.bash_profile'
alias sbp='source ~/.bash_profile'
alias hosts='sudo nano /etc/hosts'

## NAVIGATION
alias ll='ls -lahG'
alias code='cd $HOME/Code'
alias cdgo='cd $HOME/Code/Go/src'
alias cdpy='cd $HOME/Code/Python'

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
    git checkout $1
}
function gcb() {
    git checkout -b $1
}
function gcm() {
    git commit -m $1
}
function gp() {
    git pull origin $1
}
function gpr() {
    git pull --rebase origin $1
}
function gap() {
    git add -p
}
function gu() {
    git reset --soft HEAD~1
}

# Git Prompt
# 1. brew update
# 2. brew install bash-git-prompt
# 3. Paste this into ~/.bash_profile:
if [ -f "/usr/local/opt/bash-git-prompt/share/gitprompt.sh" ]; then
   __GIT_PROMPT_DIR="/usr/local/opt/bash-git-prompt/share"
   source "/usr/local/opt/bash-git-prompt/share/gitprompt.sh"
fi

## Make
function mi() {
    make image
}
function ml() {
    make local
}
function md() {
    make deps
}
function mt() {
    make test
}

## Node & Yarn
# brew install node
# brew install node@10
# etc.
function n() {
  brew unlink node
  brew link node@$1 --force --overwrite
#  echo 'export PATH="/usr/local/opt/node@$1/bin:$PATH"' >> ~/.bash_profile
}

alias y='yarn'
alias yd='yarn develop'
alias yt='yarn test'

## LOLCAT
# brew install lolcat
alias lll='ll | lolcat'
function cat() {
    lolcat $1
}
function m() {
    make $1 | lolcat
}
# brew install fortune
# brew install cowsay
alias lol='fortune | cowsay | lolcat'
# http://patorjk.com/software/taag
function fuck() {
    echo ''
    echo 'FFFFFFFFFFFFFFFFFFFFFFUUUUUUUU     UUUUUUUU       CCCCCCCCCCCCCKKKKKKKKK    KKKKKKK     YYYYYYY       YYYYYYY     OOOOOOOOO     UUUUUUUU     UUUUUUUU'
    echo 'F::::::::::::::::::::FU::::::U     U::::::U    CCC::::::::::::CK:::::::K    K:::::K     Y:::::Y       Y:::::Y   OO:::::::::OO   U::::::U     U::::::U'
    echo 'F::::::::::::::::::::FU::::::U     U::::::U  CC:::::::::::::::CK:::::::K    K:::::K     Y:::::Y       Y:::::Y OO:::::::::::::OO U::::::U     U::::::U'
    echo 'FF::::::FFFFFFFFF::::FUU:::::U     U:::::UU C:::::CCCCCCCC::::CK:::::::K   K::::::K     Y::::::Y     Y::::::YO:::::::OOO:::::::OUU:::::U     U:::::UU'
    echo '  F:::::F       FFFFFF U:::::U     U:::::U C:::::C       CCCCCCKK::::::K  K:::::KKK     YYY:::::Y   Y:::::YYYO::::::O   O::::::O U:::::U     U:::::U'
    echo '  F:::::F              U:::::D     D:::::UC:::::C                K:::::K K:::::K           Y:::::Y Y:::::Y   O:::::O     O:::::O U:::::D     D:::::U'
    echo '  F::::::FFFFFFFFFF    U:::::D     D:::::UC:::::C                K::::::K:::::K             Y:::::Y:::::Y    O:::::O     O:::::O U:::::D     D:::::U'
    echo '  F:::::::::::::::F    U:::::D     D:::::UC:::::C                K:::::::::::K               Y:::::::::Y     O:::::O     O:::::O U:::::D     D:::::U'
    echo '  F:::::::::::::::F    U:::::D     D:::::UC:::::C                K:::::::::::K                Y:::::::Y      O:::::O     O:::::O U:::::D     D:::::U'
    echo '  F::::::FFFFFFFFFF    U:::::D     D:::::UC:::::C                K::::::K:::::K                Y:::::Y       O:::::O     O:::::O U:::::D     D:::::U'
    echo '  F:::::F              U:::::D     D:::::UC:::::C                K:::::K K:::::K               Y:::::Y       O:::::O     O:::::O U:::::D     D:::::U'
    echo '  F:::::F              U::::::U   U::::::U C:::::C       CCCCCCKK::::::K  K:::::KKK            Y:::::Y       O::::::O   O::::::O U::::::U   U::::::U'
    echo 'FF:::::::FF            U:::::::UUU:::::::U  C:::::CCCCCCCC::::CK:::::::K   K::::::K            Y:::::Y       O:::::::OOO:::::::O U:::::::UUU:::::::U'
    echo 'F::::::::FF             UU:::::::::::::UU    CC:::::::::::::::CK:::::::K    K:::::K         YYYY:::::YYYY     OO:::::::::::::OO   UU:::::::::::::UU'
    echo 'F::::::::FF               UU:::::::::UU        CCC::::::::::::CK:::::::K    K:::::K         Y:::::::::::Y       OO:::::::::OO       UU:::::::::UU'
    echo 'FFFFFFFFFFF                 UUUUUUUUU             CCCCCCCCCCCCCKKKKKKKKK    KKKKKKK         YYYYYYYYYYYYY         OOOOOOOOO           UUUUUUUUU'
    echo ''
}
function fu() {
    fuck | lolcat
}


################################################################################
### Projects
function dot() {
  cd $HOME/.dotfiles
}

# dev - copy current profile to _dev project
function bbp() {
  cp $HOME/.bash_profile $HOME/.bash_profile-$(date +%Y%m%d%H%M%S)
}
function dbp() {
  bbp;
  cp $HOME/Code/_dev/bash_profile.sh $HOME/.bash_profile
  sbp;
}
function dh() {
  sudo cp /etc/hosts /etc/hosts-$(date +%Y%m%d%H%M%S);
  sudo cp $HOME/Code/_dev/hosts /etc/hosts;
}

alias dev='cd $HOME/Code/_dev'
alias never='cd $GOPATH/src/github.com/68696c6c/nevermind'

## GOAT
alias goat='cd $GOPATH/src/github.com/68696c6c/goat'
alias horns='cd $HOME/Code/horns'

## Clearlink
alias loom='cd $HOME/Code/loom'
alias lesh='cd $HOME/Code/leshen'
alias usdish='cd $HOME/Code/usdish'
alias bridge='cd $HOME/Code/the-bridge'
alias cldock='cd $HOME/Code/martech-docker'

## Kedge
function kedge() {
  case $1 in
    'dock')
      cd $HOME/Code/kedge-docker
    ;;
    'ops')
      cd $HOME/Code/kedge-ops
    ;;
    'api')
      cd ${GOPATH}/src/kedge-api
    ;;
    'web')
      cd $HOME/Code/kedge-web
    ;;
    'db')
      cd $HOME/Code/kedge-db
    ;;
    'deploy')
      cd $HOME/Code/kedge-deployment
    ;;
    'web1')
      cd $HOME/Code/kedge-web-1.0
    ;;
    'shopify')
      cd $HOME/Code/kedge-shopify
    ;;
    'big')
      cd $HOME/Code/kedge-bigcommerce
    ;;
    'magento')
      cd $HOME/Code/kedge-magento
    ;;
    'woo')
      cd $HOME/Code/kedge-woo
    ;;
  esac
}


################################################################################
## GO
export GOPATH=$HOME/Code/Go
alias gpath='echo $GOPATH'

################################################################################
## PHP
alias artisan='php artisan'
alias phpunit='vendor/bin/phpunit'

################################################################################
## Python
# Run pip inside the python:latest docker image.
alias python='python3'
alias pip='docker run --rm -it -v $PWD:$PWD --workdir $PWD python:latest pip'

################################################################################
## RUBY
# Add rbenv to bash so that it loads every time you open a terminal
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
