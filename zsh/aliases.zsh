# cat, ls, grep
alias ll="exa --all --long --header --git"
alias l="ll"
alias lls="ll --sort size --reverse --group-directories-first"
alias tree="ll --tree"
alias cat="bat --tabs 2"
alias grep="grep --color=auto"

# git
alias g="git status"
alias ga="git add"
alias gc="git commit"
alias gcm="git commit -m"
alias gca="git commit --amend --no-edit"
alias gd="git diff"
alias gdc="git diff --cached"
alias gdm="git diff origin/master"
alias gl="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all"
alias gp="git push"
alias gpf="git push --force-with-lease"
alias gpn="git push --no-verify"
alias gpnf="git push --no-verify --force-with-lease"
alias gpl="git pull --rebase"
alias gco="git checkout"
alias grc="git rebase --continue"
alias grim="git rebase -i master"
alias gcob="git checkout -b"
alias gb="git branch -a"
alias gbD="git branch | grep -v 'master' | xargs git branch -D"
alias gcom="git checkout master"
alias gpnew='git push --set-upstream origin $(git rev-parse --abbrev-ref HEAD)'
alias gpmr="ga . && gca && gpnf" # short cut to update open MR with new local changes in amended commit
alias gclean="git clean -n -f -d"
alias gauthors="git log --no-merges | grep Author | sort | uniq"
alias gcontribs="git shortlog -s -n"

# yarn
alias y="yarn"
alias ys="yarn start"
alias yt="yarn test"
alias yf="yarn flow"
alias yh="yarn health"
alias yl="yarn lint"
alias ya="yarn add"
alias yr="yarn remove"
alias yb="yarn build"
alias yw="yarn watch"

# rust
alias c="cargo"
alias cc="cargo clippy"
alias cr="cargo run"
alias cb="cargo build"
alias ct="cargo test"
alias cw="cargo watch"
alias cf="cargo fmt"

# kube
alias k="kubectl"

# docker
alias d="docker"
alias dka='d ps -q | xargs -n 1 d kill'
alias drma="d container prune --force"
alias drmia="d images -q | xargs -n 1 d rmi"
alias dspa="d system prune --all --force"

# kill
alias node0="pkill -f node"
alias flow0="pkill -f flow"
alias docker0="sudo docker system prune --all"

# utils
# Sources all zsh startup files
alias reload="exec ${SHELL} -l"
# https://github.com/mohoff/punch
alias p="punch"
# clear that does not scroll
alias clearr="printf \"\033c\""
alias wf="watch -n 1 -c -d bat"
alias update="brew update && brew upgrade"
alias clip="pbcopy"
alias myip="curl http://ipinfo.io/ip"
alias flushdns="sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder;"
alias brewclean="brew cleanup -s"
alias firefox="open -a Firefox"
alias uuid="uuidgen | tr '[:upper:]' '[:lower:]'"
alias https="http --default-scheme=https" # requires httpie
# clear trash in all mounted volues, system and download logs
alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl; sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'delete from LSQuarantineEvent'"
# Point to the newest file
alias -g NF="./*(oc[1])"
# Print PATH sorted and one per line
alias path="echo $PATH | tr ':' '\n' | sort"
alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"
# print top100 used commands logged in history
alias top100="history | tr -s ' ' | cut -d ' ' -f 5 | sort | uniq -c | sort -rns"


# Suffix aliases

alias -s {ape,avi,flv,m4a,mkv,mov,mp3,mp4,mpeg,mpg,ogg,ogm,wav,webm}=vlc
# Clone git repos by pasting git url
alias -s git="git clone"
# Code, syntax-highlight
alias -s {hs,rs,sol,js,ts,md,html,css,json,yaml,yml,toml,zsh,zsh-theme}=code
# Quick note, no highlighting
alias -s {txt,dump}=mate
