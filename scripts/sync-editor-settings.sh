#!/usr/bin/env bash
# Regenerates each VS Code-family editor's settings.json by splicing
# configs/editors/common.json with that editor's own overrides.json.
#
# Comments/formatting are preserved via a textual splice (not a JSON
# parse+re-serialize), since common.json and each overrides.json are
# designed to have zero overlapping keys — see configs/editors/common.json
# for the split rule.
#
# Usage: ./scripts/sync-editor-settings.sh
# Run this after editing configs/editors/common.json or any overrides.json.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
COMMON="$REPO_ROOT/configs/editors/common.json"

# editor-dir:label pairs
EDITORS=(
  "vscode:VS Code"
  "antigravity:Antigravity IDE"
  "cursor:Cursor"
  "kiro:Kiro"
  "windsurf:Windsurf/Devin"
)

for entry in "${EDITORS[@]}"; do
  dir="${entry%%:*}"
  label="${entry#*:}"
  overrides="$REPO_ROOT/configs/$dir/overrides.json"
  out="$REPO_ROOT/configs/$dir/settings.json"

  if [[ ! -f "$overrides" ]]; then
    echo "skip: $dir (no overrides.json)"
    continue
  fi

  python3 - "$COMMON" "$overrides" "$out" "$label" <<'PYEOF'
import sys

common_path, overrides_path, out_path, label = sys.argv[1:5]

with open(common_path) as f:
    common = f.read().rstrip()
with open(overrides_path) as f:
    overrides = f.read().rstrip()

# Strip the outer braces from each (common ends in "...}", overrides starts with "{...}")
assert common.startswith("{") and common.endswith("}"), "common.json must be a single {...} object"
assert overrides.startswith("{") and overrides.endswith("}"), "overrides.json must be a single {...} object"

common_inner = common[1:-1].rstrip()
if common_inner.endswith(","):
    common_inner = common_inner[:-1]

overrides_inner = overrides[1:-1].strip()

merged = (
    common_inner
    + ",\n\n  // =================================================\n"
    + f"  // {label} overrides (from configs/{overrides_path.split('/')[-2]}/overrides.json)\n"
    + "  // =================================================\n  "
    + overrides_inner
    + "\n}\n"
)

with open(out_path, "w") as f:
    f.write("{\n  " + merged)

print(f"generated: {out_path}")
PYEOF

done
