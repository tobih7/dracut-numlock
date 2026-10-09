#!/bin/bash

set -euo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
DST=/usr/lib/dracut/modules.d/80early-numlock

if (( EUID != 0 )); then
    exec sudo /usr/bin/bash "$SCRIPT_DIR/install.sh"
fi

if ! command -v grubby >/dev/null 2>&1; then
    echo "grubby is required to configure Plymouth's keyboard input." >&2
    exit 1
fi

install -d -m 0755 "$DST" /etc/dracut.conf.d
install -m 0644 "$SCRIPT_DIR/module/module-setup.sh" "$SCRIPT_DIR/module/numlock-hook.sh" "$DST/"
install -m 0644 "$SCRIPT_DIR/dracut.conf" /etc/dracut.conf.d/80-early-numlock.conf
if command -v restorecon >/dev/null 2>&1; then
    restorecon -RF "$DST" /etc/dracut.conf.d/80-early-numlock.conf
fi

echo "Regenerating initramfs ..."

dracut --regenerate-all --force

echo "Enabling Plymouth's console keyboard input ..."
grubby --update-kernel=ALL --args=plymouth.use-legacy-input
