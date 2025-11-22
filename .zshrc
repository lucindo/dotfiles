source $HOME/.profile

. "$HOME/.local/bin/env"

# generate uv completions
if (( $+commands[uv] )); then
    eval "$(uv generate-shell-completion zsh)"
fi

source ~/.zsh/catppuccin_frappe-zsh-syntax-highlighting.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# removing underline from path names (zsh-syntax-highlighting)
(( ${+ZSH_HIGHLIGHT_STYLES} )) || typeset -A ZSH_HIGHLIGHT_STYLES
export ZSH_HIGHLIGHT_STYLES[path]=none
export ZSH_HIGHLIGHT_STYLES[path_prefix]=none
