#!/usr/bin/env zsh

# Update if dotfiles directory is different. Also update $DOTFILES in .zshrc to the same value
export DOTFILES=$HOME/.dotfiles

# TODO: many more brew installs. Put them in install.sh? So init.sh is more a sync.sh.

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
ln -s vscode/settings.json $HOME/Library/"Application Support"/Code/User/settings.json

# ssh
echo "Symlinking ssh config..."
ln -s ssh/config $HOME/.ssh/config

# git
echo "Updating global git config includeIf..."
git config --global "includeif.gitdir:~/dev/.path" "$DOTFILES/git/dev.gitconfig"
git config --global "includeif.gitdir:~/dev/fpcomplete/.path" "$DOTFILES/git/fpco.gitconfig"
