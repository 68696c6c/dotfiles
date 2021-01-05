#!/usr/bin/env bash
# Install command-line tools using Homebrew.
# To install Brew, run this: /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Record starting packages.
brew list --versions > ~/.brew-versions-$(date +%Y%m%d%H%M%S)

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Install.
brew install bash-git-prompt
brew install lolcat
brew install go
brew install node
brew install yarn
brew install php
brew install python

# Install applications.
brew install --cask iterm2
brew install --cask docker
brew install --cask google-chrome
brew install --cask discord
brew install --cask slack
brew install --cask jetbrains-toolbox
