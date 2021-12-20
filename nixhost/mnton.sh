#!/bin/bash
# this script mounts disks from file "hardware-configuration.nix"
# creates directories at mount point

mount /dev/disk/by-uuid/2c96685d-8a04-4f82-bd3b-17b125a722e7 /mnt 
# mkdir /mnt/local
install -d /mnt{etc,local,var,boot}
install -d /mnt/root -m 0750
mount /dev/disk/by-uuid/fe45c0ad-bf5b-4af7-8909-1fb7875ccf24 /mnt/local -o subvol=@home
# mkdir /mnt/var
mount /dev/disk/by-uuid/fe45c0ad-bf5b-4af7-8909-1fb7875ccf24 /mnt/var -o subvol=@var
install -d /mnt/tmp /mnt/var/tmp -m 1777
# mkdir /mnt/boot
mount /dev/disk/by-uuid/0F5C-0954 /mnt/boot