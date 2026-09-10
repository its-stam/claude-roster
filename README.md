# claude-roster

Five role agents, each owning exactly one outcome and fenced by what it must never do; one goal in, one folder of five deliverables out.

## Results (`./test.sh`)

| What | Number |
|---|---|
| Role charters | 5 of 5 |
| Assertions in the test run | 47, all passing |
| Symlinks after `install.sh` | 3 of 3 (first run and repeat run identical) |
| Work folders created | 6 of 6 |

## The five

| Role | Owns | Fence |
|---|---|---|
| mara | finds demand: jobs, direct clients, buyers | never contacts |
| cole | writes to every name found | never sends |
| rina | makes it visible: case studies, portfolio, diagrams | never publishes |
| vince | inbox, drafts, follow-up list | never sends or deletes |
| owen | counts the week: pipeline, subscriptions, fixed costs | never pays or cancels |

Each charter ends with a routing line, so nothing needs wiring: names to mara, outreach to cole, visuals to rina, replies to vince, numbers to owen.

## Charter vs. message

A charter is what still holds true in a month: scope, finished outcome, fence. Write it once, touch it again only when a durable boundary or responsibility changes. It lives in the agent file (`agents/roster/*.md`).

Today's work goes into the message, five fields:

```
outcome:      what is finished at the end
sources:      which files, pages, accounts
constraints:  what to avoid, what to ask first
deliverable:  which form, which path
review point: where to stop and present
```

Missing a field gets a follow-up question instead of a result.

## Fence

Sending, money, publishing, deleting, agreeing stays with the human. The fence line in every charter is the second lock next to Claude Code's own permission prompt. One approval covers exactly one action and does not undo anything already done.

## Setup

```bash
git clone <repo-url>
cd claude-roster
CLAUDE_CONFIG_DIR=~/.claude ./install.sh
```

Creates three symlinks (`agents/roster`, `skills/roster`, `roster`) into your Claude Code profile and creates the work folders. `CLAUDE_CONFIG_DIR` defaults to `~/.claude`; a different work folder goes through `ROSTER_WORKDIR` (default `~/work/roster`). Run `/roster <goal>` in Claude Code afterward.

No key ships in the repo, and none belongs in it. `roster/engine-swap.sh` swaps subagent runs onto an alternative, Anthropic-API-compatible engine and reads the key at runtime from a `chmod 600` file — see `README.de.md` for the exact commands.

## Files

```
agents/roster/*.md      five charters
skills/roster/SKILL.md  /roster
roster/ROSTER.md        board, translation of the source idea onto Claude Code
roster/schichten.md     recurring runs for /schedule and /loop
roster/engine-swap.sh   engine switcher
install.sh              symlinks into the profile
tests/test_roster.sh    counting assertions, run via ./test.sh
```

## New role

Only for recurring work with its own memory and regular handoffs. Everything else becomes a skill, not an agent. Five filled cards beat twenty empty ones.

## License

MIT, see `LICENSE`. A German edition lives in `README.de.md`.
