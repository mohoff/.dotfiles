# Completions are installed by sync.sh
# The following enables completions for the aliases

# # docker
if type "docker" > /dev/null; then
  compdef d='docker';
fi

# kubectl
if type "kubectl" > /dev/null; then
  compdef k='kubectl';
fi
