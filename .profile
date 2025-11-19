export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
. "$HOME/.cargo/env"
export CLICOLOR=1
#export LSCOLORS=ExGxBxDxCxEgEdxbxgxcxd
export LSCOLORS=GxFxCxDxBxegedabagaced
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
alias vi='vim'
alias vim='nvim'
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

# Pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"

# Goenv
export GOENV_ROOT="$HOME/.goenv"
[[ -d $GOENV_ROOT/bin ]] && export PATH="$GOENV_ROOT/bin:$PATH"
eval "$(goenv init -)"

. "$HOME/.local/bin/env"
