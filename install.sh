#!/bin/bash

stow --dotfiles --dir="$HOME/dotfiles" bash
stow --dotfiles --dir="$HOME/dotfiles" git
stow --dotfiles --dir="$HOME/dotfiles/" --target="$HOME/.config/" fish
stow --dotfiles --dir="$HOME/dotfiles/" --target="$HOME/.config/" neovim
stow --dotfiles --dir="$HOME/dotfiles/" --target="$HOME/.config/" fastfetch
stow --dotfiles --dir="$HOME/dotfiles/" --target="$HOME/.config/" bat
stow --dotfiles --dir="$HOME/dotfiles/" --target="$HOME/.config/" alacritty
stow --dotfiles --dir="$HOME/dotfiles/" --target="$HOME/.config/" thefuck
stow --dotfiles --dir="$HOME/dotfiles/" --target="$HOME/.config/" starship
stow --dotfiles --dir="$HOME/dotfiles/" --target="$HOME/.config/" locale
sudo stow --dotfiles --dir="$HOME/dotfiles/" --target="/usr/share/i18n/locales" locales
