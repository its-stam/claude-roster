#!/usr/bin/env bash
# Runner: ruft die eigentlichen Tests in tests/ auf.
exec "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/tests/test_roster.sh" "$@"
