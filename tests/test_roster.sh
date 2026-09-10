#!/usr/bin/env bash
# Zaehl-Tests fuer claude-roster. Aufruf: ./test.sh (Root) oder direkt tests/test_roster.sh.
# bash 3.2 kompatibel, kein Netzwerk, keine neue Dependency.
set -u
REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO"

PASS=0
FAIL=0

ok()  { PASS=$((PASS+1)); echo "PASS: $1"; }
bad() { FAIL=$((FAIL+1)); echo "FAIL: $1"; }
assert_eq() { # desc expected actual
  if [ "$2" = "$3" ]; then ok "$1"; else bad "$1 (erwartet: $2, ist: $3)"; fi
}

# --- genau 5 Agent-Dateien unter agents/roster/ ---
agent_files=(agents/roster/*.md)
assert_eq "genau 5 Agent-Dateien unter agents/roster/" "5" "${#agent_files[@]}"

# --- Routing-Marker aus ROSTER.md lesen, nicht raten ---
MARKER="$(grep -o '`[^`]*`' roster/ROSTER.md | grep -m1 'geht an den Owner' | tr -d '`')"
if [ -n "$MARKER" ]; then
  ok "Routing-Marker aus ROSTER.md gelesen"
else
  bad "Routing-Marker in ROSTER.md nicht gefunden"
fi

# --- pro Agent-Datei: Frontmatter, genau eine Zaun-Zeile, Routing-Zeile ---
for f in "${agent_files[@]}"; do
  name="$(basename "$f" .md)"

  if head -1 "$f" | grep -q '^---$'; then
    ok "$name: Frontmatter beginnt mit ---"
  else
    bad "$name: kein Frontmatter-Start"
  fi

  fm="$(awk '/^---$/{c++; next} c==1{print} c==2{exit}' "$f")"
  if echo "$fm" | grep -q '^name:'; then ok "$name: Frontmatter hat name"; else bad "$name: Frontmatter ohne name"; fi
  if echo "$fm" | grep -q '^description:'; then ok "$name: Frontmatter hat description"; else bad "$name: Frontmatter ohne description"; fi

  never_count="$(grep -ic 'never' "$f")"
  assert_eq "$name: genau eine Zaun-Zeile (never)" "1" "$never_count"

  if [ -n "$MARKER" ]; then
    last_line="$(grep -v '^[[:space:]]*$' "$f" | tail -1)"
    case "$last_line" in
      "$MARKER"*) ok "$name: Routing-Zeile beginnt mit Marker" ;;
      *) bad "$name: Routing-Zeile beginnt NICHT mit Marker ($last_line)" ;;
    esac
  fi
done

# --- ROSTER.md nennt alle fuenf Namen ---
for n in mara cole rina vince owen; do
  if grep -qi "$n" roster/ROSTER.md; then ok "ROSTER.md nennt $n"; else bad "ROSTER.md nennt $n NICHT"; fi
done

# --- install.sh besteht bash -n ---
if bash -n install.sh; then ok "install.sh besteht bash -n"; else bad "install.sh besteht bash -n NICHT"; fi

# --- install.sh legt drei Symlinks an, zweiter Lauf aendert nichts ---
TMPCFG="$(mktemp -d)"
TMPWORK="$(mktemp -d)"

CLAUDE_CONFIG_DIR="$TMPCFG" ROSTER_WORKDIR="$TMPWORK/roster" ./install.sh >/tmp/roster-install-1.log 2>&1
r1=$?
assert_eq "install.sh erster Lauf exit 0" "0" "$r1"

for l in agents/roster skills/roster roster; do
  if [ -L "$TMPCFG/$l" ]; then ok "Symlink angelegt: $l"; else bad "Symlink fehlt: $l"; fi
done

t1_agents="$(readlink "$TMPCFG/agents/roster" 2>/dev/null || true)"
t1_skills="$(readlink "$TMPCFG/skills/roster" 2>/dev/null || true)"
t1_roster="$(readlink "$TMPCFG/roster" 2>/dev/null || true)"

CLAUDE_CONFIG_DIR="$TMPCFG" ROSTER_WORKDIR="$TMPWORK/roster" ./install.sh >/tmp/roster-install-2.log 2>&1
r2=$?
assert_eq "install.sh zweiter Lauf exit 0" "0" "$r2"

t2_agents="$(readlink "$TMPCFG/agents/roster" 2>/dev/null || true)"
t2_skills="$(readlink "$TMPCFG/skills/roster" 2>/dev/null || true)"
t2_roster="$(readlink "$TMPCFG/roster" 2>/dev/null || true)"

assert_eq "zweiter Lauf: agents/roster-Ziel unveraendert" "$t1_agents" "$t2_agents"
assert_eq "zweiter Lauf: skills/roster-Ziel unveraendert" "$t1_skills" "$t2_skills"
assert_eq "zweiter Lauf: roster-Ziel unveraendert" "$t1_roster" "$t2_roster"

for d in mara cole rina vince owen inbox; do
  if [ -d "$TMPWORK/roster/$d" ]; then ok "Arbeitsordner angelegt: $d"; else bad "Arbeitsordner fehlt: $d"; fi
done

rm -rf "$TMPCFG" "$TMPWORK"

echo
echo "TOTAL: $PASS passed, $FAIL failed"
[ "$FAIL" -eq 0 ]
