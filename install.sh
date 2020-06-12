#!/usr/bin/env zsh

# WARNING: This script hasn't been tested much. Not having a new environment.
# NOTE: To update the installed tools and sync settings, run /sync.sh.

# install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# brew formulae
brew install azure-cli \
  bat \
  curl \
  exa \
  git \
  diff-so-fancy \
  gnupg2 \
  htop \
  jq \
  kubectl \
  node \
  postgres \
  ripgrep \
  rkhunter \
  terraform \
  yarn \
  wget \
  zsh

# brew casks
brew tap homebrew/cask-fonts
brew cask install adobe-acrobat-reader \
  firefox \
  font-fira-code \
  google-chrome \
  iterm2 \
  microsoft-outlook \
  microsoft-teams \
  notion \
  slack \
  textmate \
  visual-studio-code # for installing vscode extensions, run /sync.sh
  #vlc  -- cert issue

#TODO: install istioctl

# rust tooling
if type "cargo" > /dev/null; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y;
fi

# haskell tooling
if type "stack" > /dev/null; then
  curl -sSL https://get.haskellstack.org/ | sh;
fi
