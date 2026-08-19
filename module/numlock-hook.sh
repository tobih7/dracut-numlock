#!/bin/sh

for _numlock_tty in /dev/tty[1-8]; do
    [ -c "$_numlock_tty" ] || continue
    /usr/bin/setleds -D +num < "$_numlock_tty" 2>/dev/null || :
done

unset _numlock_tty