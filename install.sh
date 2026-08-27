#!/usr/bin/env bash
# Verlinkt Roster in dein Claude-Profil. Kopiert nichts, setzt Symlinks,
# damit Repo und Profil nicht auseinanderlaufen.
#
#   ./install.sh                      # nutzt $CLAUDE_CONFIG_DIR, sonst ~/.claude
#   CLAUDE_CONFIG_DIR=~/.claude-korus ./install.sh
set -euo pipefail
REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CFG="${CLAUDE_CONFIG_DIR:-$HOME/.claude}"
[ -d "$CFG" ] || { echo "Profil nicht gefunden: $CFG"; exit 1; }

link() { # quelle ziel
  local src="$1" dst="$2"
  if [ -e "$dst" ] && [ ! -L "$dst" ]; then
    echo "Vorhanden und kein Symlink, uebersprungen: $dst"; return
  fi
  mkdir -p "$(dirname "$dst")"
  ln -sfn "$src" "$dst"
  echo "verlinkt: $dst -> $src"
}

link "$REPO/agents/roster" "$CFG/agents/roster"
link "$REPO/skills/roster" "$CFG/skills/roster"
link "$REPO/roster"        "$CFG/roster"

WORK="${ROSTER_WORKDIR:-$HOME/work/Work/ROSTER}"
mkdir -p "$WORK"/{mara,cole,rina,vince,owen,inbox}
echo "Arbeitsordner: $WORK"
echo "Fertig. In Claude Code pruefen: /roster"
