#!/usr/bin/env zsh

# NOTE: Run this script after /install.sh was run

# Update if dotfiles directory is different. Also update $DOTFILES in .zshrc to the same value
source zsh/env.zsh

# Maks zsh the default shell
chsh -s $(which zsh)

# hostname
echo "Setting hostname to '$HOSTNAME'..."
sudo scutil --set HostName $HOSTNAME

# zsh
echo "Symlinking .zshrc..."
ln -s $DOTFILES/zsh/.zshrc $HOME/.zshrc

# upgrading brew formulae and casks
echo "Updating and upgrading brew formulae..."
brew update && brew upgrade
echo "Upgrading outdated brew casks..."
brew cask outdated | xargs brew cask upgrade

# ohmyzsh and plugins
DIR_OHMYZSH="zsh/oh-my-zsh"
DIR_ZSH_SYNTAX_HIGHLIGHTING="zsh/zsh-syntax-highlighting"
DIR_ZSH_AUTOSUGGESTIONS="zsh/zsh-autosuggestions"

echo "Cloning or updating ohmyzsh..."
git clone "https://github.com/ohmyzsh/ohmyzsh.git" "$DIR_OHMYZSH" 2> /dev/null || git -C "$DIR_OHMYZSH" pull
echo "Cloning or updating zsh-syntax-highlighting..."
git clone "https://github.com/zsh-users/zsh-syntax-highlighting.git" "$DIR_ZSH_SYNTAX_HIGHLIGHTING" 2> /dev/null || git -C "$DIR_ZSH_SYNTAX_HIGHLIGHTING" pull
echo "Cloning or updating zsh-autosuggestions..."
git clone "https://github.com/zsh-users/zsh-autosuggestions.git" "$DIR_ZSH_AUTOSUGGESTIONS" 2> /dev/null || git -C "$DIR_ZSH_AUTOSUGGESTIONS" pull

# vscode
echo "Installing vscode extensions..."
cat vscode/extensions.txt | xargs -L 1 code --install-extension
echo "Symlinking vscode settings.json..."
ln -s $DOTFILES/vscode/settings.json $HOME/Library/"Application Support"/Code/User/settings.json

# ssh
echo "Symlinking ssh config..."
ln -s $DOTFILES/ssh/config $HOME/.ssh/config

# editorconfig
echo "Symlinking .editorconfig..."
ln -s $DOTFILES/.editorconfig $HOME/.editorconfig

# git
echo "Symlinking .gitconfig..."
ln -s $DOTFILES/.gitconfig $HOME/.gitconfig
echo "Updating global git config..."
# these insert tabs instead of spaces (https://stackoverflow.com/questions/32186600/how-to-make-git-config-to-use-spaces-instead-of-tabs)
git config --global "core.editor" "$EDITOR"
git config --global "core.excludesfile" "$DOTFILES/git/global.gitignore"
git config --global "core.attributesfile" "$DOTFILES/git/global.gitattributes"
git config --global "includeif.gitdir:~/dev/.path" "$DOTFILES/git/dev.gitconfig"
git config --global "includeif.gitdir:~/dev/fpcomplete/.path" "$DOTFILES/git/fpco.gitconfig"

# istioctl
echo "Symlinking istioctl..."
ln -s $ISTIO_DIR/bin/istioctl /usr/local/bin/istioctl

# z
echo "Installing z..."
mkdir -p $DOTFILES/zsh/z
curl -L https://raw.githubusercontent.com/rupa/z/master/z.sh -o $DOTFILES/zsh/z/z.sh
source $DOTFILES/zsh/z/z.sh

# completions

echo "Installing completions..."
# docker
curl -L https://raw.githubusercontent.com/docker/cli/master/contrib/completion/zsh/_docker > $DOTFILES/zsh/completions/_docker
# kubectl
kubectl completion zsh > $DOTFILES/zsh/completions/_kubectl
# istioctl
cp $ISTIO_DIR/tools/_istioctl $DOTFILES/zsh/completions/_istioctl

# haskell tooling
echo "Upgrading stack..."
# Fails in CI due to https://github.com/commercialhaskell/stack/issues/4979
stack upgrade

# source
source $HOME/.zshrc
