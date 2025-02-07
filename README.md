# My dotfiles

Contains my dotfiles

## Requirements

### Git

On ubuntu:
```bash
sudo apt install git
```

On arch:
```bash
pacman -S git
```

### Stow

On ubuntu:
```bash
sudo apt install stow
```

On arch:
```bash
pacman -S stow
```

## Installation

First, clone repo into $HOME directory

```bash
$ git clone https://github.com/Roddyck/.dotfiles.git
$ cd .dotfiles
```

then use stow to create symlinks

```
$ stow */
```
