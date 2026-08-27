#!/usr/bin/env bash
# Schritt 4 aus dem Post, fuer Claude Code: Worker-Laeufe auf Kimi K3 umbiegen.
# Key wird NIE hier hineingeschrieben. Er liegt in einer Datei mit chmod 600.
#
# Anlegen (einmal, von Hand):
#   Tuer A (Kimi Code Console, kimi.com/code/console):
#     mkdir -p ~/.config/kimi && printf '%s' 'sk-...' > ~/.config/kimi/code_api_key && chmod 600 ~/.config/kimi/code_api_key
#   Tuer B (Moonshot Pay-as-you-go, platform.moonshot.ai):
#     printf '%s' 'sk-...' > ~/.config/kimi/moonshot_api_key && chmod 600 ~/.config/kimi/moonshot_api_key
#
# Nutzen:   source ~/.claude-korus/roster/engine-kimi-k3.sh code     # oder: moonshot
# Pruefen:  echo $ANTHROPIC_BASE_URL $ANTHROPIC_MODEL ; claude   und dann /status
# Zurueck:  source ~/.claude-korus/roster/engine-kimi-k3.sh off

set -u
door="${1:-code}"

_unset_engine() {
  unset ANTHROPIC_BASE_URL ANTHROPIC_API_KEY ANTHROPIC_AUTH_TOKEN ANTHROPIC_MODEL \
        ANTHROPIC_DEFAULT_OPUS_MODEL ANTHROPIC_DEFAULT_SONNET_MODEL \
        ANTHROPIC_DEFAULT_HAIKU_MODEL CLAUDE_CODE_SUBAGENT_MODEL \
        CLAUDE_CODE_MAX_CONTEXT_TOKENS CLAUDE_CODE_AUTO_COMPACT_WINDOW
}

case "$door" in
  off)
    _unset_engine
    echo "Engine zurueck auf Anthropic (Env geleert)."
    ;;
  code)
    keyfile="$HOME/.config/kimi/code_api_key"
    [ -r "$keyfile" ] || { echo "Fehlt: $keyfile (Key aus kimi.com/code/console)"; return 1 2>/dev/null || exit 1; }
    _unset_engine
    export ANTHROPIC_BASE_URL="https://api.kimi.com/coding/"
    export ANTHROPIC_API_KEY="$(cat "$keyfile")"
    export ANTHROPIC_MODEL="k3[1m]"
    export ANTHROPIC_DEFAULT_OPUS_MODEL="$ANTHROPIC_MODEL"
    export ANTHROPIC_DEFAULT_SONNET_MODEL="$ANTHROPIC_MODEL"
    export ANTHROPIC_DEFAULT_HAIKU_MODEL="$ANTHROPIC_MODEL"
    export CLAUDE_CODE_SUBAGENT_MODEL="$ANTHROPIC_MODEL"
    export CLAUDE_CODE_MAX_CONTEXT_TOKENS=1048576
    echo "Engine: $ANTHROPIC_MODEL ueber $ANTHROPIC_BASE_URL (Tuer: Kimi Code)"
    ;;
  moonshot)
    keyfile="$HOME/.config/kimi/moonshot_api_key"
    [ -r "$keyfile" ] || { echo "Fehlt: $keyfile (Key aus platform.moonshot.ai)"; return 1 2>/dev/null || exit 1; }
    _unset_engine
    export ANTHROPIC_BASE_URL="https://api.moonshot.ai/anthropic"
    export ANTHROPIC_AUTH_TOKEN="$(cat "$keyfile")"
    export ANTHROPIC_MODEL="kimi-k3[1m]"
    export ANTHROPIC_DEFAULT_OPUS_MODEL="$ANTHROPIC_MODEL"
    export ANTHROPIC_DEFAULT_SONNET_MODEL="$ANTHROPIC_MODEL"
    export ANTHROPIC_DEFAULT_HAIKU_MODEL="$ANTHROPIC_MODEL"
    export CLAUDE_CODE_SUBAGENT_MODEL="$ANTHROPIC_MODEL"
    export CLAUDE_CODE_AUTO_COMPACT_WINDOW=1048576
    echo "Engine: $ANTHROPIC_MODEL ueber $ANTHROPIC_BASE_URL (Tuer: Moonshot)"
    ;;
  *)
    echo "Nutzung: source ${BASH_SOURCE[0]:-engine-kimi-k3.sh} [code|moonshot|off]"
    ;;
esac

# Fehlerbilder, wenn der erste Lauf schiefgeht:
#   Invalid Authentication            -> Key gehoert zur anderen Tuer
#   subscription does not have k3     -> Key stimmt, Plan nicht
#   only kimi-k3 up to 256K context   -> Modell stimmt, 1M-Kontext braucht hoeheren Plan
