#!/nin/bash
# we take the name from the file "hardware-configuration.nix"
# create a file "fallocate" or "dd", take off # 
# the numerical value depends on the memory of the mouth 512M or G and 8245M = 8.1G
fallocate -l 512M /swapfile
# dd if=/dev/zero of=/swapfile bs=1M count=512
# give read rights
chmod 600 /swapfile
# create a filesystem
mkswap /swapfile
# on files
swapon /swapfile
# for SSD, take off #
# swapon --discard /swapfile
