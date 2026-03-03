#!/bin/bash
CONF="$HOME/.config/kitty/font-size.conf"
CURRENT=$(grep -oE '[0-9]+\.[0-9]+' "$CONF")
NEW=$(echo "$CURRENT $1" | awk '{printf "%.1f", $1 + $2}')
sed -i '' "s/^font_size .*/font_size $NEW/" "$CONF"
