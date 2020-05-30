autoload -U compinit
compinit

# kubectl
source <(kubectl completion zsh)
# enable kubectl completions for aliases (see aliases.zsh)
compdef k='kubectl'
compdef kaz='k'
compdef kfp='k'

# istio
if type "istioctl" > /dev/null; then
  source $(which istioctl)/../../tools/_istioctl;
  compdef i='istioctl';
fi
