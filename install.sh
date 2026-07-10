#!/usr/bin/env bash
# Forwarder — the real script lives in scripts/install.sh.
# Kept at the root so `git clone … && ./install.sh` keeps working.
exec "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/scripts/install.sh" "$@"
