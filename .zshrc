source $HOME/.profile

. "$HOME/.local/bin/env"

# generate uv completions
if (( $+commands[uv] )); then
    eval "$(uv generate-shell-completion zsh)"
fi
