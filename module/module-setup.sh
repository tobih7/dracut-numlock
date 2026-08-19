#!/bin/bash

check() {
    require_binaries setleds || return 1
    return 0
}

depends() {
    return 0
}

install() {
    inst /usr/bin/setleds
    inst_hook cmdline 99 "$moddir/numlock-hook.sh"
}