# claude-roster

Fünf Rollen für Claude Code. Jede Rolle besitzt genau ein Ergebnis, keine besitzt eine Aufgabenliste. Gebaut nach einem X-Post, der dasselbe für ein anderes Agent-Framework beschrieben hat. Hier läuft es auf Claude Code, ohne fremden Anbieter.

## Ergebnisse (Testlauf, `./test.sh`)

| Was | Zahl |
|---|---|
| Rollen (Agent-Charters) | 5 von 5 |
| Assertionen im Testlauf | 47, alle bestanden |
| Symlinks nach `install.sh` | 3 von 3 (Erstlauf und Wiederholung identisch) |
| Arbeitsordner angelegt | 6 von 6 |

## Die fünf

| Rolle | Besitzt | Zaun |
|---|---|---|
| mara | findet Nachfrage: Jobs, Direktkunden, Abnehmer | kontaktiert nie |
| cole | schreibt an jeden gefundenen Namen | sendet nie |
| rina | macht Sichtbares: Case Studies, Portfolio, Diagramme | publiziert nie |
| vince | Posteingang, Entwürfe, Nachfass-Liste | sendet und löscht nie |
| owen | zählt die Woche: Pipeline, Abos, Fixkosten | zahlt und kündigt nie |

Am Ende jeder Charter steht eine Routing-Zeile. Deshalb muss nichts verdrahtet werden: Namen zu mara, Anschreiben zu cole, Bilder zu rina, Antworten zu vince, Zahlen zu owen.

## Installieren

```bash
git clone <repo-url>
cd claude-roster
CLAUDE_CONFIG_DIR=~/.claude ./install.sh
```

Setzt drei Symlinks (`agents/roster`, `skills/roster`, `roster`) und legt die Arbeitsordner an. Ein anderer Arbeitsordner geht über `ROSTER_WORKDIR` (Default `~/work/roster`).

## Benutzen

`/roster <ziel>` verteilt ein Ziel an die Owner, eine Stufe ein Owner, und sammelt alles in einem Ordner ein.

Charter und Nachricht sind zwei Dinge. Die Charter steht in der Agent-Datei und gilt in einem Monat noch: Bereich, fertiges Ergebnis, Zaun. Die Tagesarbeit geht in die Nachricht und trägt fünf Felder:

```
outcome:      was am Ende fertig ist
sources:      welche Dateien, Seiten, Accounts
constraints:  was zu vermeiden ist, was vorher zu fragen ist
deliverable:  welche Form, welcher Pfad
review point: wo gestoppt und vorgelegt wird
```

Fehlt ein Feld, kommt die Rückfrage statt des Ergebnisses.

## Grenze

Senden, Geld, Publizieren, Löschen, Zustimmen bleibt beim Menschen. Die Zaun-Zeile in jeder Charter ist der zweite Riegel neben dem Permission-Prompt von Claude Code. Eine Freigabe deckt genau eine Aktion und dreht nichts zurück, was schon passiert ist.

## Alternative Engine

Im Repo liegt kein Schlüssel, und es gehört auch keiner hinein. `roster/engine-swap.sh` biegt Subagent-Läufe auf eine andere, Anthropic-API-kompatible Engine um und liest den Schlüssel zur Laufzeit aus einer Datei mit `chmod 600`:

```bash
mkdir -p ~/.config/roster
printf '%s' 'DEIN_KEY' > ~/.config/roster/engine_api_key
chmod 600 ~/.config/roster/engine_api_key
source roster/engine-swap.sh on     # zurück: ... off
```

Die `.gitignore` hält Schlüsseldateien, Zugangsdaten und die Arbeitsergebnisse der Rollen draußen.

## Dateien

```
agents/roster/*.md      fünf Charters
skills/roster/SKILL.md  /roster
roster/ROSTER.md        Board, Übersetzung des Vorbilds auf Claude Code
roster/schichten.md     wiederkehrende Läufe für /schedule und /loop
roster/engine-swap.sh   Engine-Umschalter
install.sh              Symlinks ins Profil
tests/test_roster.sh    Zähl-Assertionen, Aufruf über ./test.sh
```

## Neue Rolle

Nur bei wiederkehrender Arbeit mit eigenem Gedächtnis und regelmäßigen Übergaben. Alles andere wird ein Skill. Fünf gefüllte Karten schlagen zwanzig leere.

## Lizenz

MIT, siehe `LICENSE`.
