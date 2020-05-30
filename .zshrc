export DOTFILES=$HOME/.dotfiles
source $DOTFILES/zsh/env.zsh

ZSH_THEME="agnoster-mod"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
DISABLE_MAGIC_FUNCTIONS=true # disabled to improve paste speed

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"
case $TERM in
  xterm*)
    # set icon name and window title to current directory
    # `%~`: http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html#Simple-Prompt-Escapes
    precmd () {print -Pn "\e]0;%~\a"}
    ;;
esac

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
#COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

source $ZSH/oh-my-zsh.sh

source $DOTFILES/zsh/aliases.zsh
source $DOTFILES/zsh/functions.zsh
source $DOTFILES/zsh/config.zsh

# requires running /init.sh before
source $DOTFILES/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source $DOTFILES/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

source $DOTFILES/zsh/completions.zsh
source $DOTFILES/zsh/nogit.zsh
