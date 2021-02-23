## ZSH Options
#
# relevant docs:
# - http://zsh.sourceforge.net/Guide/zshguide02.html
# - http://zsh.sourceforge.net/Doc/Release/Options.html
# - http://zsh.sourceforge.net/Doc/Release/Shell-Builtin-Commands.html
# useful commands:
# - setopt (list all enabled options)
# - emulate -LR zsh (reset all options to their defaults)

# history
setopt SHARE_HISTORY # share history across multiple zsh sessions
setopt APPEND_HISTORY # append to history instead of overwrite
setopt INC_APPEND_HISTORY # adds commands as they are typed, not at shell exit
setopt HIST_EXPIRE_DUPS_FIRST # expire duplicates first
setopt HIST_IGNORE_DUPS # do not store duplications
setopt HIST_IGNORE_ALL_DUPS  # don't record dupes in history
setopt HIST_FIND_NO_DUPS #ignore duplicates when searching
setopt HIST_REDUCE_BLANKS # removes blank lines from history
setopt EXTENDED_HISTORY # add timestamps to history

# case-insenstive globbing
setopt NO_CASE_GLOB
# e.g., both `cd ~` and `~` will work
setopt AUTO_CD
# When the last character resulting from a completion is a slash and the next character typed is a word delimiter, a slash, or a character that ends a command (such as a semicolon or an ampersand), remove the slash.
setopt AUTO_REMOVE_SLASH
# correct commands. Works with AUTO_CD
setopt CORRECT
# don't correct command arguments
unsetopt CORRECT_ALL
# don't kill background processes when shell exits
setopt NO_HUP
# don't beep on ambiguous completions
setopt NO_LIST_BEEP
# don't beep on error
setopt NO_BEEP
# If set, parameter expansion, command substitution and arithmetic expansion are performed in prompts. Substitutions within prompts do not affect the command status.
setopt PROMPT_SUBST
# If unset, the cursor is set to the end of the word if completion is started. Otherwise it stays there and completion is done from both ends.
setopt COMPLETE_IN_WORD
# Do not exit on end-of-file
setopt IGNORE_EOF
# don't expand aliases before completion has finished
setopt COMPLETE_ALIASES
# always hash before completing. Makes first completion slower but avoids false reports of errors.
setopt HASH_LIST_ALL
# If a completion is performed with the cursor within a word, and a full completion is inserted, the cursor is moved to the end of the word.
setopt ALWAYS_TO_END
# Automatically list choices on an ambiguous completion.
setopt AUTO_LIST
# This option works when AUTO_LIST or BASH_AUTO_LIST is also set. If there is an unambiguous prefix to insert on the command line, that is done without a completion list being displayed
setopt LIST_AMBIGUOUS
# On an ambiguous completion, instead of listing possibilities or beeping, insert the first match immediately. Then when completion is requested again, remove the first match and insert the second match, etc. When there are no more matches, go back to the first one again. reverse-menu-complete may be used to loop through the list in the other direction. This option overrides AUTO_MENU.
#setopt MENU_COMPLETE
setopt AUTO_MENU
# Perform textual history expansion. Type `!` followed by keyword and expand (SPACE or TAB).
setopt BANG_HIST
# Resolve symlinks before `..`. Overwritten by CHASE_DOTS.
setopt CHASE_LINKS
# Resolve `..` before symlinks. Overwrites CHASE_LINKS.
#setopt CHASE_DOTS
# Print the exit value of programs with non-zero exit status. Only works in interactive shells.
setopt PRINT_EXIT_VALUE
# allow functions to have local options
#? setopt LOCAL_OPTIONS
# allow functions to have local traps
#? setopt LOCAL_TRAPS
#? setopt HIST_VERIFY


## Completion options
#
# relevant docs: http://zsh.sourceforge.net/Doc/Release/Completion-System.html

# matches case insensitive for lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# partial completion suggestions
zstyle ':completion:*' list-suffixes
zstyle ':completion:*' expand prefix suffix
# cache completions
zstyle ':completion::complete:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
# pasting with tabs doesn't perform completion
zstyle ':completion:*' insert-tab pending
# color completions with LS_COLORS. Grays out already typed prefix
zstyle -e ':completion:*:default' list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)(?)*==02=01}:${(s.:.)LS_COLORS}")'

# Initialize the autocompletion
autoload -Uz compinit && compinit -i

# Improve SSH host autocompletions, also reads aliases from ~/.ssh/config.d/
_ssh()
{
    local cur prev opts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    opts=$(grep '^Host' ~/.ssh/config ~/.ssh/config.d/* 2>/dev/null | grep -v '[?*]' | cut -d ' ' -f 2-)

    COMPREPLY=( $(compgen -W "$opts" -- ${cur}) )
    return 0
}
complete -F _ssh ssh


# Search history with arrow keys (https://coderwall.com/p/jpj_6q/zsh-better-history-searching-with-arrow-keys)
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search # Up
bindkey "^[[B" down-line-or-beginning-search # Down
source $DOTFILES/zsh/key-bindings/fzf.zsh

# Improves navigation in autosuggestions. WORDCHARS are added to set of alphanumeric chars
export WORDCHARS='-.'

export FZF_DEFAULT_COMMAND='fd --type f'
