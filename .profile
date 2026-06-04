# Homebrew envs — must come first so brew-installed tools are on PATH below
eval "$(/opt/homebrew/bin/brew shellenv)"
export HOMEBREW_NO_ENV_HINTS=1

# Keep `brew bundle dump` to native tap/brew/cask only
export HOMEBREW_BUNDLE_DUMP_NO_GO=1
export HOMEBREW_BUNDLE_DUMP_NO_UV=1
export HOMEBREW_BUNDLE_DUMP_NO_NPM=1
export HOMEBREW_BUNDLE_DUMP_NO_CARGO=1
export HOMEBREW_BUNDLE_DUMP_NO_VSCODE=1

export CLICOLOR=1
export LS_COLORS="$(vivid generate catppuccin-frappe)"
export LC_ALL=C.UTF-8

if [[ "$TERM_PROGRAM" == "ghostty" ]]; then
    export TERM=xterm-256color
fi

# Read man pages in neovim
export MANPAGER='nvim +Man!'

# fzf theme: catppuccin-fzf-frappe
export FZF_DEFAULT_OPTS=" \
--color=bg+:#414559,bg:#303446,spinner:#F2D5CF,hl:#E78284 \
--color=fg:#C6D0F5,header:#E78284,info:#CA9EE6,pointer:#F2D5CF \
--color=marker:#BABBF1,fg+:#C6D0F5,prompt:#CA9EE6,hl+:#E78284 \
--color=selected-bg:#51576D \
--color=border:#737994,label:#C6D0F5"

# History: ignore dups and lines starting with a space, share across sessions
HISTFILE=~/.bash_history
HISTSIZE=10000
HISTFILESIZE=10000
HISTCONTROL=ignoreboth:erasedups
shopt -s histappend
PROMPT_COMMAND='history -a'

# Case insensitive completion
bind 'set completion-ignore-case on'
bind 'set completion-map-case on'

# Aliases
alias ll='ls -l'
alias la='ls -a'
alias l='ls -CF'
alias vim='nvim'
alias claude-personal='CLAUDE_CONFIG_DIR=~/.claude-personal claude'

# Setup env
. "$HOME/.local/bin/env"

# Set up fzf key bindings and fuzzy completion
eval "$(fzf --bash)"

# Homebrew-managed bash completions
if [[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]]; then
    source "/opt/homebrew/etc/profile.d/bash_completion.sh"
fi

# Starship prompt
eval "$(starship init bash)"

# Mise
eval "$(mise activate bash)"

# Generate uv completions
if type uv &>/dev/null; then
    eval "$(uv generate-shell-completion bash)"
    export PYTHONDONTWRITEBYTECODE=1
fi
