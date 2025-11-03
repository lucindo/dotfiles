export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
. "$HOME/.cargo/env"
export CLICOLOR=1
export LSCOLORS=ExGxBxDxCxEgEdxbxgxcxd
# Fallback prompt (no starhip)
export PROMPT='%n@%1~ %# '
export PS1="$PROMPT"
export LC_ALL=C.UTF-8
export TERM=xterm-256color

# No duplicate history when reverse-searching
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=5000
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt incappendhistory
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Case insensitive completion
autoload -U compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# Emacs-style keybindings
bindkey -e

# Aliases
alias htop='htop -C'
alias fzf='fzf --color=light'
alias ll='ls -l'
alias la='ls -a'
alias l='ls -CF'
alias emacs='emacsclient -nw -a "emacs -nw"'
alias emacsd='command emacs --bg-daemon'
alias emacsk='emacsclient -e "(kill-emacs)"'
alias e=emacs

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

# Starship prompt
eval "$(starship init zsh)"

# Homebrew envs
eval "$(/opt/homebrew/bin/brew shellenv)"

. "$HOME/.local/bin/env"
