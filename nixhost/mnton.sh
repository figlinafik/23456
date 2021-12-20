#!/bin/bash


mount /dev/disk/by-uuid/2c96685d-8a04-4f82-bd3b-17b125a722e7 /mnt 
mkdir /mnt/local
mount /dev/disk/by-uuid/fe45c0ad-bf5b-4af7-8909-1fb7875ccf24 /mnt/local -o subvol=@home
mkdir /mnt/var
mount /dev/disk/by-uuid/fe45c0ad-bf5b-4af7-8909-1fb7875ccf24 /mnt/var -o subvol=@var
mkdir /mnt/boot
mount /dev/disk/by-uuid/0F5C-0954
