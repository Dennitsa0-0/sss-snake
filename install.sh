#!/usr/bin/env bash
set -euo pipefail

action='install'
mode='auto'
prefix=''

while [[ $# -gt 0 ]]; do
  case "$1" in
    --user)
      mode='user'
      shift
      ;;
    --system)
      mode='system'
      shift
      ;;
    --prefix)
      if [[ $# -lt 2 ]]; then
        echo "--prefix requires a value" >&2
        exit 2
      fi
      prefix="$2"
      mode='prefix'
      shift 2
      ;;
    --uninstall)
      action='uninstall'
      shift
      ;;
    -h|--help)
      cat <<HELP
Usage:
  bash ./install.sh [--user|--system|--prefix PATH]
  bash ./install.sh --uninstall [--user|--system|--prefix PATH]

Default prefix:
  /usr/local when run as root
  \$HOME/.local otherwise
HELP
      exit 0
      ;;
    *)
      echo "Unknown option: $1" >&2
      exit 2
      ;;
  esac
done

case "$mode" in
  user)
    prefix="$HOME/.local"
    ;;
  system)
    prefix="/usr/local"
    ;;
  prefix)
    ;;
  auto)
    if [[ "${EUID:-$(id -u)}" == "0" ]]; then
      prefix="/usr/local"
    else
      prefix="$HOME/.local"
    fi
    ;;
esac

bin_dir="$prefix/bin"
script_dir="$(CDPATH= cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"

if [[ "$action" == 'uninstall' ]]; then
  rm -f "$bin_dir/sss" "$bin_dir/sss-snake"
  echo "Uninstalled from $bin_dir"
  exit 0
fi

if [[ ! -f "$script_dir/bin/sss" || ! -f "$script_dir/bin/sss-snake" ]]; then
  echo "Missing bin/sss or bin/sss-snake." >&2
  echo "Run install.sh from the project root." >&2
  exit 1
fi

if [[ "$mode" == "system" && ! -w "$bin_dir" ]]; then
  if [[ -e "$bin_dir" || ! -w "$(dirname "$bin_dir")" ]]; then
    echo "System install requires write access to /usr/local/bin." >&2
    echo "Run with sudo or use --user." >&2
    exit 1
  fi
fi

mkdir -p "$bin_dir"
install -m 0755 "$script_dir/bin/sss" "$bin_dir/sss"
install -m 0755 "$script_dir/bin/sss-snake" "$bin_dir/sss-snake"

echo "Installed SSS Snake to $bin_dir"

case ":$PATH:" in
  *":$bin_dir:"*)
    echo "Run: sss"
    ;;
  *)
    echo
    echo "Warning: $bin_dir is not in PATH."
    echo "Run now:"
    echo "  $bin_dir/sss"
    echo
    echo "Or add to PATH:"
    echo "  export PATH=\"$bin_dir:\$PATH\""
    ;;
esac
