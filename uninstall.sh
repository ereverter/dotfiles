#!/usr/bin/env bash
set -euo pipefail

targets=(
  "$HOME/.zshrc"
  "$HOME/.zprofile"
  "$HOME/.gitconfig"
  "$HOME/.gitignore_global"
  "$HOME/.tmux.conf"
  "$HOME/.config/nvim"
  "$HOME/.config/starship.toml"
  "$HOME/.config/kitty/kitty.conf"
  "$HOME/.config/kitty/font-size.conf"
  "$HOME/.config/kitty/adjust-font-size.sh"
  "$HOME/.config/karabiner/karabiner.json"
  "$HOME/.config/gh/config.yml"
  "$HOME/Library/LaunchAgents/com.eye.202020.plist"
)

restore_backup() {
  local target="$1"
  local backup="${target}.bak"
  if [ -e "$backup" ]; then
    mv "$backup" "$target"
    echo "Restored $backup"
  fi
}

for t in "${targets[@]}"; do
  if [ -L "$t" ]; then
    rm "$t"
    echo "Removed $t"
    restore_backup "$t"
  fi
done

echo "Done. Symlinks removed."
