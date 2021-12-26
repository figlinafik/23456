#!/nin/bash
#

# fallocate -l 512M /swapfile
# dd if=/dev/zero of=/swapfile bs=1M count=512
# chmod 600 /swapfile
# mkswap /swapfile
# swapon --discard /swapfile
