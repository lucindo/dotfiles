# Homebrew envs — must come first so brew-installed tools are on PATH below
eval "$(/opt/homebrew/bin/brew shellenv)"
export HOMEBREW_NO_ENV_HINTS=1

# Personal scripts (~/.bin is hidden from Finder). Prepended so it precedes
# /usr/bin — lets our `view` shadow the system one (/usr/bin/view -> vim).
export PATH="$HOME/.bin:$PATH"

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
# Don't record trivial/navigation commands (glob patterns matched against the
# whole line; 'cd' and 'cd *' are separate cases).
HISTIGNORE='ls:ls *:ll:la:l:cd:cd *:..:...:pwd:clear:exit:logout:history:history *:bg:fg:jobs'
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

# Git subcommand completion (git ships its own; not bundled by bash-completion@2).
# After fzf so it reclaims the `git` completion slot. Path derived from the
# git binary so it works on CommandLineTools, Xcode, or brew git.
if command -v git &>/dev/null; then
    _git_comp="$(git --exec-path)/../../share/git-core/git-completion.bash"
    [[ -r "$_git_comp" ]] && source "$_git_comp"
    unset _git_comp
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

# Added by Antigravity CLI installer
export PATH="/Users/lucindo/.local/bin:$PATH"

# Report cwd to the terminal (OSC 7) so new tabs/splits inherit it. Ghostty
# injects its own shell integration for this; wezterm doesn't, so emit it
# ourselves (a duplicate report is harmless). Spaces are the one reserved
# char worth encoding in real-world paths here.
__osc7_cwd() {
    printf '\033]7;file://%s%s\033\\' "${HOSTNAME:-localhost}" "${PWD// /%20}"
}
PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND; }__osc7_cwd"

FABRIC_ALIAS_PREFIX="fab-"
# Loop through all files in the ~/.config/fabric/patterns directory
for pattern_file in $HOME/.config/fabric/patterns/*; do
    # Get the base name of the file (i.e., remove the directory path)
    pattern_name="$(basename "$pattern_file")"
    alias_name="${FABRIC_ALIAS_PREFIX:-}${pattern_name}"

    # Create an alias in the form: alias pattern_name="fabric --pattern pattern_name"
    alias_command="alias $alias_name='fabric --pattern $pattern_name'"

    # Evaluate the alias command to add it to the current shell
    eval "$alias_command"
done

yt() {
    if [ "$#" -eq 0 ] || [ "$#" -gt 2 ]; then
        echo "Usage: yt [-t | --timestamps] youtube-link"
        echo "Use the '-t' flag to get the transcript with timestamps."
        return 1
    fi

    transcript_flag="--transcript"
    if [ "$1" = "-t" ] || [ "$1" = "--timestamps" ]; then
        transcript_flag="--transcript-with-timestamps"
        shift
    fi
    local video_link="$1"
    fabric -y "$video_link" $transcript_flag
}

# pnpm
export PNPM_HOME="/Users/lucindo/Library/pnpm"
case ":$PATH:" in
*":$PNPM_HOME/bin:"*) ;;
*) export PATH="$PNPM_HOME/bin:$PATH" ;;
esac
# pnpm end
