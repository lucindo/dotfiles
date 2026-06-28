source $HOME/.profile


# Added by Antigravity CLI installer
export PATH="/Users/lucindo/.local/bin:$PATH"

# pnpm
export PNPM_HOME="/Users/lucindo/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME/bin:"*) ;;
  *) export PATH="$PNPM_HOME/bin:$PATH" ;;
esac
# pnpm end
