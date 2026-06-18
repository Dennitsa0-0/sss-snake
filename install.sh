#!/usr/bin/env bash
set -euo pipefail

prefix="${PREFIX:-$HOME/.local}"
action='install'

while [[ $# -gt 0 ]]; do
  case "$1" in
    --prefix)
      if [[ $# -lt 2 ]]; then
        echo "--prefix requires a value" >&2
        exit 2
      fi
      prefix="$2"
      shift 2
      ;;
    --uninstall)
      action='uninstall'
      shift
      ;;
    -h|--help)
      cat <<HELP
Usage:
  ./install.sh [--prefix PATH]
  ./install.sh --uninstall [--prefix PATH]

Default prefix:
  $HOME/.local
HELP
      exit 0
      ;;
    *)
      echo "Unknown option: $1" >&2
      exit 2
      ;;
  esac
done

bin_dir="$prefix/bin"

if [[ "$action" == 'uninstall' ]]; then
  rm -f "$bin_dir/sss" "$bin_dir/sss-snake"
  echo "Uninstalled from $bin_dir"
  exit 0
fi

mkdir -p "$bin_dir"
install -m 0755 "$(dirname "$0")/bin/sss" "$bin_dir/sss"
install -m 0755 "$(dirname "$0")/bin/sss-snake" "$bin_dir/sss-snake"

echo "Installed SSS Snake to $bin_dir"
echo "Run: sss"

case ":$PATH:" in
  *":$bin_dir:"*) ;;
  *)
    echo "Note: $bin_dir is not in PATH. Add this to your shell profile:"
    echo "  export PATH=\"$bin_dir:\$PATH\""
    ;;
esac
