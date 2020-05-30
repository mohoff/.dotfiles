# `dotfiles`

A collection of dotfiles and zsh config - mostly for Mac. Themed with bright colors and high contrasts for us sunny boys ☀️

## Background

Finally switched from fish to zsh and wanted to find a new home for my dotfiles and other configuration. Hope this makes it a breeze to setup my next machine. After a weekend of experimentation, my setup consists of:

- zsh, [`oh-my-zsh`](https://github.com/ohmyzsh/ohmyzsh) (one day without this bloat I hope), syntax-highlighting, and auto-suggestions.
- modified [Agnoster theme](https://github.com/agnoster/agnoster-zsh-theme)
- modified [Snazzy color profile](https://github.com/sindresorhus/iterm2-snazzy)
- a bunch of completions, aliases, functions, and environment variables

Thanks to all the makers for their open source work that I was allowed to build on top of.

## How to use

Backup your existing configuration. The following steps assume a bare environment. Use at your own risk!

1. Install iTerm2 as terminal on MacOS.
1. Install zsh and [`oh-my-zsh`](https://github.com/ohmyzsh/ohmyzsh).
1. Make zsh the default shell by running `chsh -s $(which zsh)`.
1. Clone this repo into the home directory and rename it to be hidden (`.dotfiles/`)
1. Move or symlink `.zshrc` and `.editorconfig` into your home directory.
1. Run `init.sh`. It will install the plugins [`zsh-autosuggestions`](https://github.com/zsh-users/zsh-autosuggestions) and [`zsh-syntax-highlighting`](https://github.com/zsh-users/zsh-syntax-highlighting)
1. Download and install the _[FireCode](https://github.com/tonsky/FiraCode/wiki/Installing)_ font.
1. Create a iTerm2 profile (_Preferences > Profile_) and set is as default.
   - Go to the _Colors_ tab and import the color preset `snazzy_mod.itermcolors`. It is using bright colors and is largely based on [`iterm2-snazzy`](https://github.com/sindresorhus/iterm2-snazzy).
   - Go to the _Keys_ tab and select _Natural Text Editing_ under the _Presets..._ dropdown. This improves `zsh-autosuggestions` a lot as you can navigate through the suggestions and segments by (`⌥` +) arrow keys.
   - Go to the _Text_ tab and select the _FiraCode_ font. Enable ligatures.
1. _Optional_: Update `zsh/nogit.example.zsh` to your needs.
1. Source the zsh configuration by running `source ~/.zshrc`, or `reload` in case the aliases have been sourced already.

## Updates

`git pull` in the repo directory `~/.dotfiles`. Diff the newly pulled files with the ones in your home directory (i.e, `.zshrc` and `.editorconfig`) and edit/replace/symlink accordingly.


## TODO

- add vscode config
- add fuzzyfinder
- gitattributes/git configs
- build prompt and completions for `punch`
- more init.sh stuff: `brew install...`.
- fix differently rendered colors in vscode terminal
- fix git dirty color - always (sometimes?) stays green where it should be yellow/red
