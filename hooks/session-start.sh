#!/usr/bin/env bash
# Tells Claude a vibe-sdlc project's state at session start.
# Silent outside vibe-sdlc projects. Informational only: it never tells Claude to act.

dir="${CLAUDE_PROJECT_DIR:-$PWD}"
state="$dir/docs/sdlc/STATE.md"
[ -f "$state" ] || exit 0

# Pull the "Now" and "Continue in a fresh chat" sections, capped at 30 lines.
summary=$(awk '
  /^## /{ keep = ($0 ~ /^## (Now|Continue in a fresh chat)/) }
  keep { print }
' "$state" | head -n 30)

cat <<EOF
This repository is a vibe-sdlc project. Its process state is in docs/sdlc/STATE.md:

$summary

If the user wants to continue the project, use the vibe-sdlc:next skill. Otherwise just help with what they ask; don't start project work on your own.
EOF
exit 0
