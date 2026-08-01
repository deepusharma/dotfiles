#!/usr/bin/env bash
# Regenerates each VS Code-family editor's settings.json by splicing
# configs/editors/common.json with that editor's own overrides.json.
#
# Comments/formatting are preserved via a textual splice (not a JSON
# parse+re-serialize), since common.json and each overrides.json are
# designed to have zero overlapping keys — see configs/editors/common.json
# for the split rule.
#
# Before overwriting each configs/<editor>/settings.json, shows a diff
# against the current file and flags any settings keys that exist there
# right now but are NOT in common.json or overrides.json — these are
# almost always live edits made through an editor's Settings UI (which
# writes straight into this generated file, bypassing common/overrides),
# and would otherwise be silently lost. Prompts before applying unless
# -y/--yes is passed.
#
# Usage: ./scripts/sync-editor-settings.sh [-y|--yes]
# Run this after editing configs/editors/common.json or any overrides.json.

set -euo pipefail

AUTO_YES=0
for arg in "$@"; do
  [[ "$arg" == "-y" || "$arg" == "--yes" ]] && AUTO_YES=1
done

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
  tmp="$(mktemp)"

  if [[ ! -f "$overrides" ]]; then
    echo "skip: $dir (no overrides.json)"
    rm -f "$tmp"
    continue
  fi

  python3 - "$COMMON" "$overrides" "$tmp" "$label" "$dir" <<'PYEOF'
import sys

common_path, overrides_path, out_path, label, dirname = sys.argv[1:6]

with open(common_path) as f:
    common = f.read().rstrip()
with open(overrides_path) as f:
    overrides = f.read().rstrip()

assert common.startswith("{") and common.endswith("}"), "common.json must be a single {...} object"
assert overrides.startswith("{") and overrides.endswith("}"), "overrides.json must be a single {...} object"

common_inner = common[1:-1].rstrip()
if common_inner.endswith(","):
    common_inner = common_inner[:-1]

overrides_inner = overrides[1:-1].strip()

merged = (
    common_inner
    + ",\n\n  // =================================================\n"
    + f"  // {label} overrides (from configs/{dirname}/overrides.json)\n"
    + "  // =================================================\n  "
    + overrides_inner
    + "\n}\n"
)

with open(out_path, "w") as f:
    f.write("{\n  " + merged)
PYEOF

  if [[ ! -f "$out" ]]; then
    mv "$tmp" "$out"
    echo "generated (new): $out"
    continue
  fi

  if diff -q "$out" "$tmp" >/dev/null 2>&1; then
    rm -f "$tmp"
    echo "unchanged: $out"
    continue
  fi

  echo ""
  echo "=================================================="
  echo "$label — $out"
  echo "=================================================="
  diff -u "$out" "$tmp" || true

  # Flag keys present in the CURRENT file but absent from the freshly
  # generated one — these would be silently lost (almost always a live
  # Settings-UI edit that never made it into common.json/overrides.json).
  python3 - "$out" "$tmp" <<'PYEOF'
import sys, re, json

def load_jsonc(path):
    with open(path) as f:
        raw = f.read()
    lines = [l for l in raw.split("\n") if not l.strip().startswith("//")]
    text = "\n".join(lines)
    text = re.sub(r',(\s*[}\]])', r'\1', text)
    return json.loads(text)

old_path, new_path = sys.argv[1], sys.argv[2]
try:
    old = load_jsonc(old_path)
    new = load_jsonc(new_path)
except Exception as e:
    print(f"  (could not parse for key-loss check: {e})")
    sys.exit(0)

lost = sorted(set(old.keys()) - set(new.keys()))
if lost:
    print("")
    print(f"  WARNING: {len(lost)} key(s) in the current file are NOT in common.json")
    print(f"  or overrides.json — applying this sync will LOSE them:")
    for k in lost:
        print(f"    - {k}")
    print(f"  If any of these should stick around, add them to common.json or")
    print(f"  this editor's overrides.json first, then re-run this script.")
PYEOF

  if [[ "$AUTO_YES" -eq 1 ]]; then
    mv "$tmp" "$out"
    echo "applied: $out"
  elif [[ -t 0 ]]; then
    reply=""
    read -r -p "Apply this change to $out? [y/N] " reply || true
    if [[ "$reply" =~ ^[Yy]$ ]]; then
      mv "$tmp" "$out"
      echo "applied: $out"
    else
      rm -f "$tmp"
      echo "skipped: $out"
    fi
  else
    rm -f "$tmp"
    echo "skipped: $out (non-interactive shell — re-run with -y/--yes to apply, or run interactively to confirm)"
  fi
done
