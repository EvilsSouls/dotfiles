# My Dotfiles

## Requirements

This is a collection of my dotfiles. Being managed by [Gnu Stow](https://www.gnu.org/software/stow/), you need both it and [git](https://git-scm.com/).

If you do not have these packages you can install them using your favorite package manager. As I use arch, *btw*, I will use pacman:

```sh
pacman -S git stow
```

## Installation

To install the actual dotfiles clone this repository and run the install script:

```sh
git clone https://github.com/EvilsSouls/dotfiles.git ~/dotfiles
~/dotfiles/install.sh
```

The install script will run the necessary `git stow` commands to populate the ~/.config and home directory with the appropriate dotfiles.

## Uninstall

To uninstall all dotfiles you will have to modify the `install.sh` file.[^2] For every `gnu stow` command inside the file add the -D flag.

> [!EXAMPLE]
> `gnu stow --dotfiles --dir="$HOME/dotfiles" --target="$HOME/.config/" neovim` should become `gnu stow -D --dotfiles --dir="$HOME/dotfiles" --target="$HOME/.config/" neovim`

## Notes

I am actually using stow somewhat differently than how it is supposed to be used. Instead of simply running `git stow <package>` inside the `~/dotfiles` directory I also specify the target directory for packages that don't live inside the home directory. This is usually a package which has its config files under `~/.config/<package>`. Instead of simply recreating this directory structure I decided to store the config files directly in the `~/dotfiles/<package>` directory. This is in my opinion cleaner, with the drawback of needing a more complicated `stow` command.

Since the current solution is very weird, I am planning on maybe making a rust application similar to stow, with some improvements so that it better suits my needs.[^1]

[^1]: I imagine the application supporting a flag where the package directory can act like the configuration file itself

[^2]: I could also create a `uninstall.sh` script, however this would require me to always update two files when adding a new package to stow.
