#!/usr/bin/env bash

# NOTE: After running this script, run /sync.sh

set -exo pipefail

source zsh/env.zsh

# istio
command -v "istioctl" \
  || curl -L https://istio.io/downloadIstio | sh - \
  && mkdir -p $ISTIO_DIR \
  && mv istio-$ISTIO_VERSION/* $ISTIO_DIR \
  && sudo ln -s $ISTIO_DIR/bin/istioctl /usr/local/bin/istioctl

# rust tooling
command -v "cargo" \
  || curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# haskell tooling
command -v "stack" \
  || curl -sSL https://get.haskellstack.org/ | sh -s

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
      shellcheck \
      terraform \
      tokei \
      yarn \
      wget \
      zsh

    # brew casks
    brew tap homebrew/cask-fonts
    brew cask install \
      adobe-acrobat-reader \
      bitwarden \
      firefox \
      flux \
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
      rkhunter \
      unzip \
      wget \
      zsh

    # azure-cli
    curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
    # awscliv2
    curl -sL "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    unzip awscliv2.zip
    sudo ./aws/install
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
    # kustomize
    curl -sL "https://raw.githubusercontent.com/\
kubernetes-sigs/kustomize/master/hack/install_kustomize.sh" | bash
    sudo mv kustomize /usr/local/bin/
    # prepare neofetch
    sudo add-apt-repository ppa:dawidd0811/neofetch
    # prepare nodejs
    curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
    # ripgrep (via apt only with ubuntu 18.10 or newer)
    curl -sL "https://github.com/BurntSushi/ripgrep/releases/download/12.1.1/ripgrep-12.1.1-x86_64-unknown-linux-musl.tar.gz" -o ripgrep.tar.gz
    tar -xvf ripgrep.tar.gz
    sudo mv ripgrep-12.1.1-x86_64-unknown-linux-musl/rg /usr/local/bin/
    # terraform
    curl -sL "https://releases.hashicorp.com/terraform/0.12.26/terraform_0.12.26_linux_amd64.zip" -o terraform.zip
    unzip terraform.zip
    sudo mv terraform /usr/local/bin/
    # tokei
    cargo install tokei
    # yarn
    curl -o- -L https://yarnpkg.com/install.sh | bash

    sudo apt update && sudo apt install -y \
      neofetch \
      nodejs \
      postgresql
  ;;
  dragonfly*|freebsd*|netbsd*|openbsd*)
    echo "Unsupported \$OSTYPE $OSTYPE"
  ;;
esac

# verify installation
istioctl version
cargo --version
stack --version
az --version
aws --version
bat --version
diff-so-fancy --version || true
exa --version
delta --version
jq --version
kubectl version --client=true
kustomize version
node --version
psql --version
rg --version
terraform version
yarn --version

neofetch
