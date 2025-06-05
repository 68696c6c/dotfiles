#!/usr/bin/env bash
# Install command-line tools using Homebrew.
# To install Brew, run this: /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Record starting packages.
brew list --versions > ~/.brew-versions

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Install.
brew install coreutils
brew install bash-git-prompt
brew install lolcat
brew install git-lfs
brew install go
brew install node
brew install node@22
brew install yarn
brew install php
brew install python
brew install hashicorp/tap/terraform
brew install jq
brew install yq
brew install awscli

# Install applications.
brew install --cask iterm2
brew install --cask docker
brew install --cask google-chrome
brew install --cask firefox
brew install --cask discord
brew install --cask slack
brew install --cask jetbrains-toolbox
brew install --cask aws-vault
brew install --cask insomnia
#brew install --cask guitar-pro
brew install --cask figma
