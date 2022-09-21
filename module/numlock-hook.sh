#!/bin/sh

TTYs=/dev/tty[1-6]
for tty in $TTYs; do
    /usr/bin/setleds -D +num <$tty
done
