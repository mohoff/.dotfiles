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
brew outdated --cask | xargs brew cask upgrade

# ohmyzsh and plugins
echo "Pulling latest master: ohmyzsh..."
git -C "$ZSH" pull
echo "Pulling latest master: zsh-syntax-highlighting..."
git -C "$ZSH_SYNTAX_HIGHLIGHTING" pull
echo "Pulling latest master: zsh-autosuggestions..."
git -C "$ZSH_AUTOSUGGESTIONS" pull

# vscode
echo "Installing vscode extensions..."
cat vscode/extensions.txt | xargs -L 1 code --install-extension
echo "Symlinking vscode settings.json..."
ln -s $DOTFILES/vscode/settings.json $HOME/Library/"Application Support"/Code/User/settings.json
echo "Symlinking vscode keybindings.json..."
ln -s $DOTFILES/vscode/keybindings.json $HOME/Library/"Application Support"/Code/User/keybindings.json

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

# z
echo "Sourcing z..."
source $DOTFILES/tools/z/z.sh

# completions
echo "Installing completions..."
# docker
curl -L https://raw.githubusercontent.com/docker/cli/master/contrib/completion/zsh/_docker > $DOTFILES/zsh/completions/_docker
# kubectl
kubectl completion zsh > $DOTFILES/zsh/completions/_kubectl

# source
echo "Sourcing .zshrc..."
source $HOME/.zshrc
