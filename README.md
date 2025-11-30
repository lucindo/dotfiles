# Lucindo's dotfiles

Personal dotfiles, using [GNU stow](https://www.gnu.org/software/stow/manual/stow.html) to manage them.

On max OS X, first install [brew](https://brew.sh/):

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)""
```

Then clone this repo:

```bash
git clone https://github.com/lucindo/dotfiles.git ~/Code/dotfiles
```

Command line tools and dependencies can be individually installed with `brew install`. List of all the tools used in this repo can be found in the [Brewfile](Brewfile). To install the bundle simply run:

```bash
brew bundle
```

To have `nvim` properly working (and dev env), install the following via `mise`:

```bash
mise plugins add lua
mise use -g lua@5.1
mise use -g node
mise use -g rust@nightly
muse use -g go
mise use -g python
```

And symlink the dotfiles:

```bash
cd ~/Code/dotfiles
stow -t $HOME -R .
```

You can now edit the files in `~/Code/dotfiles` and they will be symlinked to `~/`.

To remove the symlinks, run:

```bash
stow -t $HOME -D .
```
