#!/usr/bin/env bash
# Env-Swap fuer Subagent-Laeufe auf eine alternative, Anthropic-API-kompatible Engine.
# Key wird NIE hier hineingeschrieben. Er liegt in einer Datei mit chmod 600.
#
# Anlegen (einmal, von Hand):
#   mkdir -p ~/.config/roster
#   printf '%s' 'DEIN_KEY' > ~/.config/roster/engine_api_key
#   chmod 600 ~/.config/roster/engine_api_key
#
# Vor dem ersten Lauf anpassen: BASE_URL und MODEL unten auf den Anbieter deiner Wahl setzen.
#
# Nutzen:   source $CLAUDE_CONFIG_DIR/roster/engine-swap.sh on
# Pruefen:  echo $ANTHROPIC_BASE_URL $ANTHROPIC_MODEL ; claude   und dann /status
# Zurueck:  source $CLAUDE_CONFIG_DIR/roster/engine-swap.sh off

set -u
door="${1:-on}"

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
  on)
    keyfile="$HOME/.config/roster/engine_api_key"
    [ -r "$keyfile" ] || { echo "Fehlt: $keyfile (Key vom gewaehlten Anbieter)"; return 1 2>/dev/null || exit 1; }
    _unset_engine
    export ANTHROPIC_BASE_URL="https://api.example.com/anthropic"   # anpassen
    export ANTHROPIC_AUTH_TOKEN="$(cat "$keyfile")"
    export ANTHROPIC_MODEL="<modell-id>"                             # anpassen
    export ANTHROPIC_DEFAULT_OPUS_MODEL="$ANTHROPIC_MODEL"
    export ANTHROPIC_DEFAULT_SONNET_MODEL="$ANTHROPIC_MODEL"
    export ANTHROPIC_DEFAULT_HAIKU_MODEL="$ANTHROPIC_MODEL"
    export CLAUDE_CODE_SUBAGENT_MODEL="$ANTHROPIC_MODEL"
    echo "Engine: $ANTHROPIC_MODEL ueber $ANTHROPIC_BASE_URL"
    ;;
  *)
    echo "Nutzung: source ${BASH_SOURCE[0]:-engine-swap.sh} [on|off]"
    ;;
esac

# Fehlerbilder, wenn der erste Lauf schiefgeht:
#   Invalid Authentication          -> Key gehoert zum falschen Endpunkt
#   subscription/plan mismatch      -> Key stimmt, Plan deckt das Modell nicht
#   Kontextfenster zu klein         -> hoeherer Plan oder anderes Modell noetig
