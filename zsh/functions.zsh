# first things first
function weather {
  curl wttr.in/$1
}

# haskell
function sdex {
  # sdev + run executable defined in package.yaml
  sdev --exec $(cat package.yaml | grep executables: -A 1 -m 1 | tail -n1 | tr -d ' :') $@
}

# view csv data
# based on https://github.com/paulirish/dotfiles/blob/453b3863346c5a419260b32b4c058e8d84920813/.functions#L97
function viewcsv() {
  sed 's/,,/, ,/g;s/,,/, ,/g' "$@" | column -s, -t
}

# extract archives
# from https://github.com/paulirish/dotfiles/blob/453b3863346c5a419260b32b4c058e8d84920813/.functions#L103
function extract() {
  if [ -f "$1" ] ; then
    local filename=$(basename "$1")
    local foldername="${filename%%.*}"
    local fullpath=`perl -e 'use Cwd "abs_path";print abs_path(shift)' "$1"`
    local didfolderexist=false
    if [ -d "$foldername" ]; then
      didfolderexist=true
      read -p "$foldername already exists, do you want to overwrite it? (y/n) " -n 1
      echo
      if [[ $REPLY =~ ^[Nn]$ ]]; then
        return
      fi
    fi
    mkdir -p "$foldername" && cd "$foldername"
    case $1 in
      *.tar.bz2) tar xjf "$fullpath" ;;
      *.tar.gz) tar xzf "$fullpath" ;;
      *.tar.xz) tar Jxvf "$fullpath" ;;
      *.tar.Z) tar xzf "$fullpath" ;;
      *.tar) tar xf "$fullpath" ;;
      *.taz) tar xzf "$fullpath" ;;
      *.tb2) tar xjf "$fullpath" ;;
      *.tbz) tar xjf "$fullpath" ;;
      *.tbz2) tar xjf "$fullpath" ;;
      *.tgz) tar xzf "$fullpath" ;;
      *.txz) tar Jxvf "$fullpath" ;;
      *.zip) unzip "$fullpath" ;;
      *) echo "'$1' cannot be extracted via extract()" && cd .. && ! $didfolderexist && rm -r "$foldername" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# show whois for URL or domain
# from https://github.com/paulirish/dotfiles/blob/453b3863346c5a419260b32b4c058e8d84920813/.functions#L72
function whois() {
  local domain=$(echo "$1" | awk -F/ '{print $3}') # get domain from URL
  if [ -z $domain ] ; then
    domain=$1
  fi
  echo "Getting whois record for: $domain …"

  /usr/bin/whois -h whois.internic.net $domain | sed '/NOTICE:/q'
}

function f() {
  case $1 in
    ssh)
      INPUT=$(rg --only-matching --no-line-number --no-heading --no-filename -e '^Host (.*)' ~/.ssh/** -r '$1' | sort -r)
      ;;
    gb)
      INPUT=$(git branch -a --format='%(refname:short)')
      ;;
    de)
      INPUT=$(docker ps --format '{{.Image}}')
      ;;
    k)
      INOUT=$(kubectl get all --all-namespaces --no-headers --output custom-columns=":metadata.namespace,:metadata.name")
      ;;
    ke | kl)
      INPUT=$(kubectl get pods --all-namespaces --no-headers --output custom-columns=":metadata.namespace,:metadata.name")
      ;;
    *)
      echo "command not supported for fuzzy search"
      ;;
  esac

  SELECTED=$(echo $INPUT | fzf)

  case $1 in
    ssh)
      # is this needed?: fzf | xargs -o ssh
      ssh $SELECTED
      ;;
    gb)
      git checkout $SELECTED
      ;;
    de)
      docker exec -it $SELECTED -- /bin/bash
      ;;
    k | ke | kl)
      # TODO: test this
      NAMESPACE=$(echo $SELECTED | tr -s ' ' | cut -f1 -d ' ')
      NAME=$(echo $SELECTED | tr -s ' ' | cut -f2 -d ' ')

      # https://stackoverflow.com/questions/47691479/listing-all-resources-in-a-namespace
      case $1 in
        k)
          kubectl $2 $NAME -n $NAMESPACE
          ;;
        ke)
          kubectl exec -it $NAME -n $NAMESPACE -- /bin/bash
          ;;
        kl)
          kubectl logs $NAME -n $NAMESPACE --all-containers --follow
          ;;
        *)
          echo "unknown kubectl fuzzy search"
          ;;
      esac
      ;;
    *)
      echo "command not supported for fuzzy search"
      ;;
  esac
}

# attach to docker container with shell
function attach() {
    docker exec -it $@ /bin/sh
}
