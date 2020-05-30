# Weather forecast on the terminal, e.g. `weather odessa`
function weather {
  curl wttr.in/$1
}

# haskell
function sdex {
  # sdev + run executable defined in package.yaml
  sdev --exec $(cat package.yaml | grep executables: -A1 | tail -n1 | tr -d ' :') $@
}
