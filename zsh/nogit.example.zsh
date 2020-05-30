# This file can be used for anything (aliases, functions, etc.) that should be gitignored. For example, secrets, personalizations, or an alias containing a path that leaks sensitive information.

# If this file should be sourced, rename it to nogit.zsh
# Please note that this file is sourced last.

# git
GIT_AUTHOR_NAME="Joe Freeman"
GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"
GIT_AUTHOR_EMAIL="joe@free.man"
GIT_COMMITTER_EMAIL="$GIT_AUTHOR_EMAIL"

git config --global user.name "$GIT_AUTHOR_NAME"
git config --global user.email "$GIT_AUTHOR_EMAIL"
