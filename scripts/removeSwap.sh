swapoff /swap/swapfile
rm -rf /swap/swapfile
btrfs subvolume delete /swap
