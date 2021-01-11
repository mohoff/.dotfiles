# Completions are installed by sync.sh
# The following enables completions for the aliases

# # docker
if type "docker" > /dev/null; then
  compdef d='docker';
fi