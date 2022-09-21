#!/bin/bash

check() { return 0; }

depends() { return 0; }

install() {
    inst_hook pre-trigger 91 "$moddir/numlock-hook.sh"
    inst "/usr/bin/setleds" "/usr/bin/setleds"
}
