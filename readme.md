Instruction: Run setup-arch.sh

This assumes you've run archinstall with configurations:
- Kernels: linux (set by default)
- Bootloader: Bootloader "Systemd-boot" UKI Enabled (set by default)
- Profile: Server (sshd)
- Disk Configuration: Btrfs snapshot "Snapper" (with subvolumes only @ and @home)

| Subvolume name | Mount point |
| --- | --- |
| @ | / |
| @home | /home |
	
	
