#!/usr/bin/env zsh

# NOTE: After running this script, run /sync.sh

set -euo pipefail

source zsh/env.zsh

# Only CI: Remove pre-installed dependencies on GitHub Actions macOS runners
[[ $CI ]] && brew remove --force $(brew list)

# install brew
command -v "brew" || \
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# brew formulae
brew install \
  azure-cli \
  awscli \
  bat \
  curl \
  exa \
  git \
  git-delta \
  diff-so-fancy \
  gnupg \
  htop \
  jq \
  kubectl \
  kustomize \
  neofetch \
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
brew cask install \
  adobe-acrobat-reader \
  bitwarden \
  firefox \
  font-fira-code \
  google-chrome \
  iterm2 \
  microsoft-outlook \
  microsoft-teams \
  notion \
  slack \
  textmate \
  visual-studio-code \
  vlc

# istio
command -v "istioctl" \
  || curl -L https://istio.io/downloadIstio | sh - \
  && mkdir -p $ISTIO_DIR \
  && mv istio-$ISTIO_VERSION/* $ISTIO_DIR

# rust tooling
command -v "cargo" \
  || curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# haskell tooling
command -v "stack" \
  || curl -sSL https://get.haskellstack.org/ | sh -s -- -y
