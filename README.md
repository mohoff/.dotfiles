# `.dotfiles`

A collection of dotfiles and zsh config - mostly for Mac. Themed with bright colors and high contrasts for us sunny boys ☀️

![screenshot](assets/screenshot.png)

## Background

Finally switched from fish to zsh and wanted to find a new home for my dotfiles and other configuration. Hope this makes it a breeze to setup my next machine. After a weekend of experimentation, my setup consists of:

- zsh, [`oh-my-zsh`](https://github.com/ohmyzsh/ohmyzsh) (one day without this bloat I hope), syntax-highlighting, and auto-suggestions.
- modified [Agnoster theme](https://github.com/agnoster/agnoster-zsh-theme)
- modified [Snazzy color profile](https://github.com/sindresorhus/iterm2-snazzy)
- a bunch of completions, aliases, functions, and environment variables

Thanks to all the makers for their open source work that I was allowed to build on top of.

## How to use

Backup your existing configuration. The following steps assume a bare environment. Use at your own risk!

*Preparation*:
- Install iTerm2 as terminal on MacOS.
- Install zsh and [`oh-my-zsh`](https://github.com/ohmyzsh/ohmyzsh).
- Download and install the _[FireCode](https://github.com/tonsky/FiraCode/wiki/Installing)_ font.
- Make zsh the default shell by running `chsh -s $(which zsh)`.

*Setup*:
1. Clone this repo into your home directory so that there is `~/.dotfiles`.
1. Move up or symlink `.zshrc` and `.editorconfig` to have both in the home directory.
1. Run `init.sh`. It will install:
    - [`oh-my-zsh`](https://github.com/ohmyzsh/ohmyzsh) framework
    - [`zsh-autosuggestions`](https://github.com/zsh-users/zsh-autosuggestions) and [`zsh-syntax-highlighting`](https://github.com/zsh-users/zsh-syntax-highlighting) plugins
1. Create an iTerm2 profile (_Preferences > Profile_) and set it as default.
   - Go to the _Colors_ tab and import the color preset `theming/snazzy_mod.itermcolors`.
   - Go to the _Keys_ tab and select _Natural Text Editing_ under the _Presets..._ dropdown. This improves `zsh-autosuggestions` a lot as you can navigate through the suggestions and segments by (`⌥` +) arrow keys.
   - Go to the _Text_ tab and select the _FiraCode_ font. Enable ligatures.
1. _Optional_: Update `zsh/nogit.example.zsh` to your needs. Delete `/assets`.
1. Source the zsh configuration by running `source ~/.zshrc`, or `reload` in case the aliases have been sourced already.

## Updates

`git pull` in the repo directory `~/.dotfiles`. Diff the newly pulled files with the ones in your home directory (i.e, `.zshrc` and `.editorconfig`) and edit/replace/symlink accordingly.


## TODO

- add fuzzyfinder
- gitattributes/git configs
- more init.sh stuff: `brew install...`.
- improve git dirty color - signal that files can be staged
- better define tool requirements: istioctl, kubectl, exa, bat, ...
- CI (Github actions) for dotfiles?
- set hostname: `sudo scutil --set HostName name-you-want`
- Switch to https://github.com/dandavison/delta when https://github.com/dandavison/delta/issues/177#issuecomment-635711834 is released
