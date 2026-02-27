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
  "$HOME/.config/karabiner/karabiner.json"
  "$HOME/.config/gh/config.yml"
)

for t in "${targets[@]}"; do
  if [ -L "$t" ]; then
    rm "$t"
    echo "Removed $t"
    # restore backup if one exists
    [ -f "${t}.bak" ] && mv "${t}.bak" "$t" && echo "Restored ${t}.bak"
  fi
done

echo "Done. Symlinks removed."
