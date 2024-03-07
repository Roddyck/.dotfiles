# My dotfiles

Contains my dotfiles

## Requirements

### Git

```
sudo apt-get install git-all
```

### Stow

```
sudo apt install stow
```

## Installation

First, clone repo into $HOME directory

```
$ git clone git@github.com:Roddyck/.dotfiles.git
$ cd .dotfiles
```

then use stow to create symlinks

```
$ stow */
```
