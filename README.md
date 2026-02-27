# dotfiles

macOS dev environment: zsh, git, tmux, neovim (LazyVim), starship, karabiner.

## Setup

```bash
git clone git@github.com:ereverter/dotfiles.git ~/projects/dotfiles
cd ~/projects/dotfiles
./install.sh        # symlinks, brew packages, optionally macOS defaults
./macos.sh          # run standalone if you skipped it during install
```

Edit `~/.gitconfig-work` with your work email. Work projects go under `~/work/`.

## Daily use

Configs are symlinked, so editing e.g. `~/.zshrc` edits the repo file directly. After changes:

```bash
cd ~/projects/dotfiles && git add -A && git commit -m "update X" && git push
```

Run `update` in any shell to update brew packages and nvim plugins.
