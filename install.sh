#!/bin/bash
set -e

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG="$HOME/.config"
BACKUP="$HOME/.config-backup-$(date +%Y%m%d%H%M%S)"

CONFIG_DIRS=(aerospace fastfetch ghostty nvim sketchybar starship)

link_config() {
    local name="$1"
    local src="$DOTFILES/$name"
    local dst="$CONFIG/$name"

    if [ -L "$dst" ]; then
        # already a symlink, just update
        ln -sfn "$src" "$dst"
        echo "  updated: $dst"
    elif [ -d "$dst" ]; then
        # real dir — back up first
        mkdir -p "$BACKUP"
        mv "$dst" "$BACKUP/$name"
        echo "  backed up: $dst -> $BACKUP/$name"
        ln -sfn "$src" "$dst"
        echo "  linked: $dst -> $src"
    else
        ln -sfn "$src" "$dst"
        echo "  linked: $dst -> $src"
    fi
}

echo "==> Linking .config dirs..."
for dir in "${CONFIG_DIRS[@]}"; do
    link_config "$dir"
done

echo "==> Linking shell files..."
ZSHRC_DST="$HOME/.zshrc"
ZSHRC_SRC="$DOTFILES/zsh/.zshrc"
if [ -L "$ZSHRC_DST" ]; then
    ln -sf "$ZSHRC_SRC" "$ZSHRC_DST"
    echo "  updated: $ZSHRC_DST"
elif [ -f "$ZSHRC_DST" ]; then
    cp "$ZSHRC_DST" "$BACKUP/.zshrc" 2>/dev/null || mkdir -p "$BACKUP" && cp "$ZSHRC_DST" "$BACKUP/.zshrc"
    echo "  backed up: $ZSHRC_DST -> $BACKUP/.zshrc"
    ln -sf "$ZSHRC_SRC" "$ZSHRC_DST"
    echo "  linked: $ZSHRC_DST -> $ZSHRC_SRC"
else
    ln -sf "$ZSHRC_SRC" "$ZSHRC_DST"
    echo "  linked: $ZSHRC_DST -> $ZSHRC_SRC"
fi

echo ""
echo "Done. Edit files in $DOTFILES — changes tracked by git automatically."
[ -d "$BACKUP" ] && echo "Backups at: $BACKUP"
