# path
export PATH=$HOME/bin:$PATH
export PATH=$HOME/.cargo/bin:$PATH # rust
export PATH=$HOME/.local/bin:$PATH # haskell
export PATH=$(brew --prefix git)/share/git-core/contrib/diff-highlight:$PATH

export fpath=($DOTFILES/zsh/functions $DOTFILES/zsh/completions $fpath)

export SHELL=$(which zsh)
export EDITOR=vim

# oh-my-zsh
export ZSH=$DOTFILES/zsh/oh-my-zsh
export ZSH_CUSTOM=$DOTFILES/theming

# lang
export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'

# history
export HIST_STAMPS="yyyy-mm-dd"
export HISTFILE=~/.zsh_history
export HISTSIZE=10000
export SAVEHIST=10000

# colors
# useful tool: https://geoff.greer.fm/lscolors/
# LSCOLORS and LS_COLORS refer to different formats of the same color scheme
export LSCOLORS="ExgxBxdxCxDxDxCdCdexex" # colors matching `exa` colors
export LS_COLORS="di=1;34:ln=36:so=1;31:pi=33:ex=1;32:bd=1;33:cd=1;33:su=1;32;43:sg=1;32;43:tw=34:ow=34"
