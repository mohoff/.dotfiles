#!/usr/bin/env bash

# NOTE: After running this script, run /sync.sh

set -exo pipefail

source zsh/env.zsh

# rust tooling
command -v "cargo" \
  || curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
cargo install cargo-watch

case "$OSTYPE" in
  darwin*)
    echo "Installing MacOS tools..."

    # Only CI: Remove pre-installed dependencies on GitHub Actions macOS runners
    [[ $CI ]] && brew remove --force $(brew list)

    # install brew
    command -v "brew" || \
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

    # brew formulae
    brew update || brew update
    brew upgrade
    brew install \
      bat \
      coreutils \
      curl \
      exa \
      git \
      git-delta \
      diff-so-fancy \
      gnupg \
      htop \
      jq \
      kubectl \
      node \
      ripgrep \
      shellcheck \
      yarn \
      webp \
      wget \
      zsh

    # brew casks
    brew tap homebrew/cask-fonts
    brew install --cask \
      adobe-acrobat-reader \
      firefox \
      font-fira-code \
      google-chrome \
      iterm2 \
      slack \
      sublime-text \
      visual-studio-code
  ;;
  linux*)
    # NOTE: No GUIs, no fonts

    echo "Installing Linux tools..."
    sudo apt update && sudo apt upgrade
    sudo apt install -y \
      curl \
      git \
      gnupg \
      htop \
      unzip \
      wget \
      zsh

    # bat (via apt only with ubuntu 19.10 or newer)
    curl -sL "https://github.com/sharkdp/bat/releases/download/v0.15.4/bat-v0.15.4-x86_64-unknown-linux-musl.tar.gz" -o bat.tar.gz
    tar -xvf bat.tar.gz
    sudo mv bat-v0.15.4-x86_64-unknown-linux-musl/bat /usr/local/bin/
    # diff-so-fancy
    git clone https://github.com/so-fancy/diff-so-fancy.git
    sudo chmod +x diff-so-fancy/diff-so-fancy
    sudo ln -s diff-so-fancy/diff-so-fancy /usr/local/bin/diff-so-fancy
    # exa
    cargo install exa
    # prepare firacode font
    sudo add-apt-repository universe
    # git-delta
    curl -sL "https://github.com/dandavison/delta/releases/download/0.1.1/delta-0.1.1-x86_64-unknown-linux-musl.tar.gz" -o "gitdelta.tar.gz"
    tar -xvf gitdelta.tar.gz
    sudo mv delta-0.1.1-x86_64-unknown-linux-musl/delta /usr/local/bin/
    # jq (v1.6)
    curl -sL "https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64" -o jq
    chmod +x jq
    sudo mv jq /usr/local/bin/
    ls -al /usr/local/bin
    # kubectl
    curl -sLO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
    chmod +x kubectl
    sudo mv kubectl /usr/local/bin/
    # prepare nodejs
    curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
    # ripgrep (via apt only with ubuntu 18.10 or newer)
    curl -sL "https://github.com/BurntSushi/ripgrep/releases/download/12.1.1/ripgrep-12.1.1-x86_64-unknown-linux-musl.tar.gz" -o ripgrep.tar.gz
    tar -xvf ripgrep.tar.gz
    sudo mv ripgrep-12.1.1-x86_64-unknown-linux-musl/rg /usr/local/bin/
    # yarn
    curl -o- -L https://yarnpkg.com/install.sh | bash

    sudo apt update && sudo apt install -y nodejs
  ;;
  dragonfly*|freebsd*|netbsd*|openbsd*)
    echo "Unsupported \$OSTYPE $OSTYPE"
  ;;
esac

# verify installation
cargo --version
bat --version
diff-so-fancy --version || true
exa --version
delta --version
jq --version
kubectl version --client=true
node --version
rg --version
yarn --version
