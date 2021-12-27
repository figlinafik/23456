#!/bin/bash
# we take the name from the file "hardware-configuration.nix"
# create a file "fallocate" or "dd", take off # 
# the numerical value depends on the memory of the mouth 512M or G and 8245M = 8.1G
sudo fallocate -l 8245M  /mnt/.swapfile.swap
# dd if=/dev/zero of=/swapfile bs=1M count=512
# give read rights
sudo chmod 600 /mnt/.swapfile.swap
# create a filesystem
sudo mkswap /mnt/.swapfile.swap
# on files
sudo swapon /mnt/.swapfile.swap
# for SSD, take off #
# swapon --discard /mnt/.swapfile.swap
