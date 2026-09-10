---
name: tailor
type: skill
description: Stellenanzeige rein, zugeschnittener ATS-Lebenslauf plus Match-Report raus. Arbeitet aus dem Master-CV und der Baustein-Bibliothek, erfindet nichts, benennt Luecken. Trigger /tailor <url-oder-text>.
trigger: /tailor
aliases: [/cv-zuschnitt, /ats]
---

# Skill: tailor

Was im Reel ein Claude-Projekt macht, hier als ein Befehl. Jeder Lauf startet frisch, das Gedaechtnis sind die Dateien, nicht der Chatverlauf.

## Quellen (lokal, nie in ein Remote)

| Was | Pfad |
|---|---|
| Master-CV | `~/work/bewerbungen/cv-master.md` |
| ATS-Kopf | `~/work/bewerbungen/cv-kopf-ats.md` |
| Belegte Bullets | `~/work/bewerbungen/bausteine.md` |
| Tracker | `~/work/bewerbungen/tracker.csv` |
| Ausgabe | `~/work/bewerbungen/drafts/YYYY-MM-DD/` |

Positionierung und verifizierte Zahlen folgen der Vorgabe des Menschen. Nie aufrunden, nie umetikettieren.

## Ablauf

1. **Anzeige holen.** URL per Browser lesen, oder eingefuegten Text nehmen. Firma, Rolle, Ort, Zeitzone, Sprache, Gehalt festhalten.
2. **Keywords ziehen.** Aus der Anzeige die harten Anforderungen als Liste. Tools, Methoden, Jahre, Sprachen, Zertifikate. Wortlaut der Anzeige beibehalten, denn danach filtert das ATS.
3. **Abgleichen.** Jedes Keyword in drei Toepfe:
   - **belegt** — steht so im Master-CV oder in den Bausteinen, mit Fundstelle
   - **teilweise** — verwandt, muss ehrlich umformuliert werden
   - **fehlt** — kommt nicht in den CV, wird als Luecke ausgewiesen
4. **Zuschneiden.** Reihenfolge der Abschnitte und Bullets nach Anzeige sortieren, Wortlaut der Anzeige aufnehmen wo es der Wahrheit entspricht. Nur Bullets aus den Bausteinen verwenden. Kein neuer Job, keine neue Zahl, kein neues Tool.
5. **Schreiben.** Zwei Dateien in den Tagesordner:
   - `<firma>-<rolle>-cv.md` — der zugeschnittene Lebenslauf
   - `<firma>-<rolle>-match.md` — Keyword-Tabelle, Trefferquote, Luecken, und eine Zeile was du vor dem Absenden pruefen musst
6. **Tracker.** Eine Zeile anhaengen mit Status `draft`.
7. **Vorlegen.** Trefferquote, die drei groessten Luecken, Pfade. Fertig.

## Match-Report (feste Form)

```markdown
Firma / Rolle / Quelle / Sprache
Trefferquote: X von Y harten Anforderungen belegt

| Keyword aus Anzeige | Status | Fundstelle im CV |
|---|---|---|

Luecken (nicht im CV, nicht erfinden):
- ...

Vor dem Absenden pruefen:
- ...
```

## Harte Regeln

- Nichts behaupten, was nicht in Master-CV oder Bausteinen steht. Fehlt ein Keyword, bleibt es eine Luecke, auch wenn es die Quote druckt.
- Sprache folgt der Anzeige. Englische Anzeige, englischer CV.
- Kein Formular ausfuellen, nichts hochladen, nichts absenden. Der Draft liegt im Ordner, der Mensch schickt.
- Trefferquote unter etwa der Haelfte heisst, die Stelle passt nicht. Sagen statt schoenrechnen.
- Personendaten bleiben lokal, nie in ein Repo.

## Verhaeltnis zu apply100

`/apply100` macht Menge: scrapen, matchen, Anschreiben in zwei Tiers. `/tailor` macht Tiefe fuer eine Stelle, CV plus Match-Report. Bei Tier A beide, sonst reicht apply100.
