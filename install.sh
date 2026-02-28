#!/usr/bin/env bash
set -euo pipefail

DOTFILES="$(cd "$(dirname "$0")" && pwd)"

info() { printf "\033[0;34m[info]\033[0m %s\n" "$1"; }
ok()   { printf "\033[0;32m[ok]\033[0m   %s\n" "$1"; }
warn() { printf "\033[0;33m[warn]\033[0m %s\n" "$1"; }

link() {
  local src="$1" dst="$2"
  if [ -L "$dst" ]; then
    rm "$dst"
  elif [ -f "$dst" ] || [ -d "$dst" ]; then
    warn "Backing up existing $dst to ${dst}.bak"
    mv "$dst" "${dst}.bak"
  fi
  ln -sf "$src" "$dst"
  ok "Linked $dst -> $src"
}

# Homebrew
if ! command -v brew &>/dev/null; then
  info "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
info "Installing Homebrew packages..."
brew bundle --file="$DOTFILES/Brewfile"

# Shell
link "$DOTFILES/zsh/.zshrc" "$HOME/.zshrc"
link "$DOTFILES/zsh/.zprofile" "$HOME/.zprofile"

# Git
link "$DOTFILES/git/.gitconfig" "$HOME/.gitconfig"
link "$DOTFILES/git/.gitignore_global" "$HOME/.gitignore_global"

# Tmux
link "$DOTFILES/tmux/.tmux.conf" "$HOME/.tmux.conf"

# Neovim
mkdir -p "$HOME/.config"
link "$DOTFILES/nvim" "$HOME/.config/nvim"

# Starship
link "$DOTFILES/starship/starship.toml" "$HOME/.config/starship.toml"

# Karabiner
mkdir -p "$HOME/.config/karabiner"
link "$DOTFILES/karabiner/karabiner.json" "$HOME/.config/karabiner/karabiner.json"

# GitHub CLI
mkdir -p "$HOME/.config/gh"
link "$DOTFILES/gh/config.yml" "$HOME/.config/gh/config.yml"

# SSH
if [ ! -f "$HOME/.ssh/config" ]; then
  warn "No SSH config found. See ssh/config.example for reference."
fi

# Git work config placeholder
if [ ! -f "$HOME/.gitconfig-work" ]; then
  info "Creating placeholder ~/.gitconfig-work"
  cat > "$HOME/.gitconfig-work" <<'EOF'
[user]
    email = you@company.com
EOF
  warn "Edit ~/.gitconfig-work with your work email"
fi

# macOS defaults
if [[ "$OSTYPE" == darwin* ]]; then
  read -p "Apply macOS defaults? [y/N] " -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    "$DOTFILES/macos.sh"
  fi
fi

echo ""
ok "Done. Restart your shell or run: source ~/.zshrc"
