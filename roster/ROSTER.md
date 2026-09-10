# Roster — fuenf Owner, ein Abend Setup

Stand 27.08.2026. Vorbild: ein X-Post ueber eine Multi-Agent-Belegschaft mit austauschbarer Engine, hier auf Claude Code umgebaut. Ziel: Einkommensaufbau, nicht Spielerei.

## Was der Post wollte, was hier steht

| Post | Claude Code | Ort |
|---|---|---|
| Personal hiren | Subagent-Datei | `$CLAUDE_CONFIG_DIR/agents/roster/*.md` |
| Charter statt To-do | Agent-Body: Owns / Works from / Deliverable / Never | dieselbe Datei |
| Logins einmal geben | MCP-Server, sonst Chrome-Extension mit deiner Session | `settings.json`, claude-in-chrome |
| Engine waehlen | Env-Swap fuer Subagent-Laeufe | `$CLAUDE_CONFIG_DIR/roster/engine-swap.sh` |
| Nach Ownership hiren | fuenf Rollen, ein Outcome je Rolle | Tabelle unten |
| Handoff untereinander | Agent-Tool + Routing-Zeile in jeder Charter | `/roster` |
| Schicht | `/schedule` (Cron) und `/loop` | `schichten.md` |
| Geteilter Cloud-Rechner mit root | gibt es so nicht bei Claude | offen, siehe unten |

## Die fuenf

| Name | Owns | Output-Ordner | Zaun |
|---|---|---|---|
| Mara | Nachfrage finden: Jobs, Direktkunden, Abnehmer | `~/work/roster/mara/` | kontaktiert nie |
| Cole | Ansprache schreiben: Proposals, Kaltmails, Partner-Nachrichten | `.../cole/` | sendet nie |
| Rina | Sichtbares: Case Studies, Portfolio, Diagramme | `.../rina/` | publiziert nie |
| Vince | Posteingang, Entwuerfe, Nachfass-Liste | `.../vince/`, `.../inbox/` | sendet und loescht nie |
| Owen | Wochenzahlen, Abos, Pipeline | `.../owen/` | zahlt und kuendigt nie |

Routing-Zeile steht am Ende jeder Charter, deshalb muss nichts verdrahtet werden: Namen zu Mara, Anschreiben zu Cole, Bilder zu Rina, Antworten zu Vince, Zahlen zu Owen.

## Routing-Marker

Jede Charter endet mit genau einer Zeile, die mit diesem Marker beginnt: `Was nicht mir gehoert, geht an den Owner:`

## Charter gegen Nachricht

Charter ist das, was in einem Monat noch stimmt: Bereich, fertiges Ergebnis, Zaun. Wird einmal geschrieben und nur angefasst, wenn eine dauerhafte Grenze oder Zustaendigkeit dazukommt.

Heutige Arbeit geht in die Nachricht, fuenf Felder: outcome, sources, constraints, deliverable, review point. Fehlt eins, kommt die Rueckfrage und der Abend ist weg.

Korrektur fuer heute in die Nachricht. Regel fuer naechsten Monat in die Charter.

## Zaun (identisch in allen fuenf)

Senden, Geld, Publizieren, Loeschen, Zustimmen. Bei Claude Code kommt das per Permission-Prompt sowieso hoch, die Charter-Zeile ist der zweite Riegel. Eine Freigabe deckt genau die eine Aktion und dreht nichts zurueck.

## Was Claude anders macht als der Post

- Kein dauerhaft laufender geteilter Rechner mit vielen Instanzen und root. Subagenten leben in der Session, Dauerlaeufe kommen ueber `/schedule` (Cloud-Agent auf Cron) oder `/loop`.
- Kein Login-Takeover-Fenster. Zugriff laeuft ueber MCP-Server oder die Chrome-Extension in deinem eigenen Profil. Passwoerter tippt weiter der Mensch, nichts davon in den Chat.
- Handoff ist echt, aber orchestriert: Claude verteilt, die fuenf antworten. Keine Agenten, die sich nachts von selber anschreiben.
- Versteckte Engines und root-Shell im Vorbild-Post sind Teardown-Erzaehlung, kein Beleg. Ignoriert.

## Erweitern

Neue Rolle nur bei wiederkehrender Arbeit mit eigenem Gedaechtnis und regelmaessigen Uebergaben. Einmal-Job wird Skill. Fuenf gefuellte Karten schlagen zwanzig leere.
