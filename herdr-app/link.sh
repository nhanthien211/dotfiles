#!/bin/sh
# Links the files in this folder that belong to the person into the Herdr app's
# config folder, so a fresh machine gets them back from the dotfiles repo.
#
#   ~/Documents/dotfiles/herdr-app/link.sh            link into ~/.config/herdr-app
#   ~/Documents/dotfiles/herdr-app/link.sh --dry-run  show what would happen
#   HERDR_APP_HOME=/some/dir link.sh                  another Herdr home
#
# Safe to run again: it creates missing links, repoints links at a moved repo,
# and never replaces a real file or folder. Files it doesn't own (Herdr's
# shipped layouts, mods, themes, icons, frame, *.d.ts, AGENTS.md) and runtime
# state (view.json, shared.json, data/, installed.json, window*.json,
# layouts/.state/) are never linked, because Herdr rewrites them.

set -eu

repo_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
home_dir=${HERDR_APP_HOME:-$HOME/.config/herdr-app}
dry_run=0

for arg in "$@"; do
  case $arg in
    -n | --dry-run) dry_run=1 ;;
    --home=*) home_dir=${arg#*=} ;;
    -h | --help)
      awk 'NR > 1 && /^#/ { sub(/^# ?/, ""); print; next } NR > 1 { exit }' "$0"
      exit 0
      ;;
    *)
      echo "link.sh: unknown argument: $arg" >&2
      exit 2
      ;;
  esac
done

if [ ! -d "$home_dir" ]; then
  echo "link.sh: $home_dir does not exist." >&2
  echo "Install Herdr, open it once, quit it, then run this again." >&2
  exit 1
fi

linked=0
kept=0
skipped=0

# link <source> <destination>
link() {
  src=$1
  dst=$2
  if [ -L "$dst" ]; then
    current=$(readlink "$dst")
    current=${current%/}
    if [ "$current" = "${src%/}" ]; then
      kept=$((kept + 1))
      return
    fi
  elif [ -e "$dst" ]; then
    echo "skip    $dst (a real file or folder; not touching it)"
    skipped=$((skipped + 1))
    return
  fi

  if [ "$dry_run" = 1 ]; then
    echo "link    $dst -> $src"
  else
    ln -sfn "$src" "$dst"
    echo "link    $dst -> $src"
  fi
  linked=$((linked + 1))
}

# Top-level files. programs.json is optional.
for name in settings.json keys.json programs.json; do
  if [ -f "$repo_dir/$name" ]; then
    link "$repo_dir/$name" "$home_dir/$name"
  fi
done

# One link per file: layouts/, themes/ and mods/ also hold Herdr's own, which
# it rewrites on every start, so the folders themselves can't be linked.
for src in "$repo_dir"/layouts/*.json; do
  [ -f "$src" ] || continue
  link "$src" "$home_dir/layouts/$(basename "$src")"
done

for src in "$repo_dir"/themes/*.json; do
  [ -f "$src" ] || continue
  link "$src" "$home_dir/themes/$(basename "$src")"
done

for src in "$repo_dir"/mods/*; do
  [ -d "$src" ] || continue
  link "$src" "$home_dir/mods/$(basename "$src")"
done

# Links into this repo whose file is gone (deleted or renamed here).
for dst in "$home_dir"/*.json "$home_dir"/layouts/*.json "$home_dir"/themes/*.json "$home_dir"/mods/*; do
  [ -L "$dst" ] || continue
  target=$(readlink "$dst")
  case $target in
    "$repo_dir"/*)
      if [ ! -e "$target" ]; then
        echo "stale   $dst -> $target (gone from the repo; remove the link or restore the file)"
      fi
      ;;
  esac
done

if [ "$dry_run" = 1 ]; then
  echo "dry run: $linked to link, $kept already linked, $skipped skipped"
else
  echo "$linked linked, $kept already linked, $skipped skipped"
fi

# Only the app's real home can be asked about; HERDR_APP_HOME is honored by
# herdr-app, but a test home has no window behind it.
if [ "$dry_run" = 0 ] && [ "$home_dir" = "$HOME/.config/herdr-app" ] &&
  command -v herdr-app >/dev/null 2>&1; then
  status=$(herdr-app status 2>/dev/null || true)
  case $status in
    *'"errors": []'*) ;;
    *)
      echo "note: 'herdr-app status' did not report a clean state; check it while Herdr runs"
      ;;
  esac
fi
