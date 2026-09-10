---
name: roster
type: skill
description: Startet die Fuenf-Rollen-Belegschaft (Mara, Cole, Rina, Vince, Owen) auf ein Ziel. Verteilt die Arbeit nach Ownership, sammelt die Ergebnisse in einem Ordner, stoppt vor jeder Aktion nach aussen. Trigger /roster [ziel].
trigger: /roster
aliases: [/crew, /belegschaft]
---

# Skill: roster

Ein Ziel rein, fuenf Owner arbeiten, ein Ordner raus. Kein Agent geht nach aussen.

## Rollen (Charter: `$CLAUDE_CONFIG_DIR/agents/roster/`)

| Name | Owns | Zaun |
|---|---|---|
| mara | findet Namen, die kaufen koennten | kontaktiert nie |
| cole | schreibt an jeden Namen | sendet nie |
| rina | macht Portfolio, Case Studies, Diagramme | publiziert nie |
| vince | Posteingang und Nachfassen | sendet und loescht nie |
| owen | zaehlt die Woche | zahlt und kuendigt nie |

## Ablauf

1. **Ziel pruefen.** Fehlt Outcome, Quelle, Deliverable, Grenze oder Reviewpunkt, genau eine Frage stellen, sonst laufen lassen.
2. **Owner zuordnen.** Pro Stufe genau ein Owner. Zwei Owner auf derselben Stufe heisst, der Report kommt doppelt.
3. **Parallel starten.** Unabhaengige Stufen in einem Rutsch per Agent-Tool, abhaengige Stufen nacheinander. Jeder Agent bekommt die fuenf Felder:
   - outcome, sources, constraints, deliverable, review point
4. **Handoff.** Ergebnis von Stufe n woertlich als Quelle in Stufe n+1 nennen, nicht nacherzaehlen.
5. **Cap.** Maximal 3 Runden pro Owner. Ist ein Owner nach 3 Runden nicht fertig, Uebergabe an den Menschen mit der offenen Liste, keine vierte Runde.
6. **Abschluss-Satz je Owner.** Jede Owner-Antwort endet mit genau einem Satz im Format `VERIFIED: <was geprueft wurde>` oder `NOT VERIFIED: <was fehlt>`. Read-only-Owner (mara, owen) ergaenzen zusaetzlich den Satz "reads only, never writes to the repository or sends anything".
7. **Einsammeln.** Alles nach `~/work/roster/<owner>/`, Ordnername in der Antwort nennen.
8. **Vorlegen.** Eine Seite: was fertig ist, was wartet, was der Mensch abschicken muss. Nie "erledigt" ohne Dateipfad.

## Arbeitskarte (Vorlage)

```markdown
outcome:      was am Ende fertig ist
sources:      welche Dateien, Seiten, Accounts
constraints:  was zu vermeiden ist, was vorher zu fragen ist
deliverable:  welche Form, welcher Pfad
review point: wo gestoppt und vorgelegt wird
```

## Harte Grenze (gilt fuer alle fuenf)

Senden, Geld, Publizieren, Loeschen, Zustimmen bleibt beim Menschen. Freigabe gilt fuer genau die eine Aktion und macht nichts rueckgaengig, was schon passiert ist. Siehe `$CLAUDE_CONFIG_DIR/rules/approval.md`.

## Schichten

Wiederkehrende Laeufe stehen in `$CLAUDE_CONFIG_DIR/roster/schichten.md`. Anlegen per `/schedule`, Intervall-Lauf per `/loop`.

## Regel fuer neue Rollen

Neue Rolle nur, wenn die Arbeit wiederkehrt, eigenes Gedaechtnis braucht und regelmaessig an andere uebergibt. Alles andere wird ein Skill, kein Agent.
