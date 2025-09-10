# Lucindo's dotfiles

Personal dotfiles, using [GNU stow](https://www.gnu.org/software/stow/manual/stow.html) to manage them.

On max OS X, first install [brew](https://brew.sh/):

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)""
```

Then install stow:

```bash
brew install stow
```

Other command line tools and dependencies can be individually installed with `brew install`. List of all the tools used in this repo can be found in the [Brewfile](Brewfile). To install the bundle simply run:

```bash
brew bundle
```

Then clone this repo:

```bash
git clone https://github.com/lucindo/dotfiles.git ~/Code/dotfiles
```

And symlink the dotfiles:

```bash
cd ~/Code/dotfiles
stow -t ~ -R .
```

You can now edit the files in `~/Code/dotfiles` and they will be symlinked to `~/`.

To remove the symlinks, run:

```bash
stow -t ~ -D .
```
