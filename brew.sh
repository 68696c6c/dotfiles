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
brew install lolcat
brew install git-lfs
brew install go
brew install node
brew install node@14 # LTS
brew install node@16 # Latest
brew install yarn
brew install php
brew install python
brew install ruby@3.0.1
brew install postgres
brew install awscli
brew install jq

# Install applications.
brew install --cask iterm2
brew install --cask docker
brew install --cask google-chrome
brew install --cask firefox
brew install --cask discord
brew install --cask slack
brew install --cask jetbrains-toolbox
brew install --cask istat-menus
