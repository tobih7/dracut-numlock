## dracut-numlock

When the initramfs prompts for a LUKS password, the numpad may be disabled even though it is enabled in the BIOS/UEFI.
This module enables Num Lock on Linux virtual consoles 1-8 during dracut's early `cmdline` stage, before Plymouth starts.
It applies to systems using dracut to generate the initramfs, such as Fedora. It cannot change a password prompt displayed by GRUB itself.

Run the installer:

```sh
./install.sh
```

The installer requires `dracut` and `grubby`, and uses `pkexec` for root access when run as a regular user.
It installs the module as `80early-numlock` and regenerates the initramfs images for all installed kernels.
The configuration in `/etc/dracut.conf.d/80-early-numlock.conf` explicitly enables `early-numlock` and omits Fedora's later `numlock` module.
The distinct module name avoids a collision with Fedora's packaged `70numlock` module.

After rebuilding, the installer runs:

```sh
grubby --update-kernel=ALL --args=plymouth.use-legacy-input
```

This persists the argument for current and future Fedora boot entries. Running the installer again does not duplicate it.
Plymouth then reads keyboard input from the console, so the module's Num Lock setting also controls keypad input at the graphical disk-unlock prompt.
The boot-time keyboard layout comes from `KEYMAP` in `/etc/vconsole.conf`, rather than the `XKB*` options.
Without this argument, Plymouth's separate XKB state can start with Num Lock disabled even when the console state and keyboard LED are enabled.
This workaround changes only Plymouth's boot-time input handling; the desktop still uses its normal keyboard input handling.

To remove the workaround later:

```sh
pkexec grubby --update-kernel=ALL --remove-args=plymouth.use-legacy-input
```

Reboot to test Num Lock at the disk-unlock prompt.
