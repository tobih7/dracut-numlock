#!/bin/bash

DST=/usr/lib/dracut/modules.d/90numlock/

set -e

sudo mkdir -p "$DST"
sudo cp "$(dirname $0)/module"/*.sh "$DST"

echo "Regenerating initramfs ..."

sudo dracut --regenerate-all --force
