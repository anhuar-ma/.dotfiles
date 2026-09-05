# Docs: https://wiki.archlinux.org/title/Btrfs#Swap_file
#
btrfs subvolume create /swap
btrfs filesystem mkswapfile --size 20g --uuid clear /swap/swapfile
swapon -p 0 /swap/swapfile
echo "Add to /etc/fstab"
echo "/swap/swapfile none swap defaults 0 0"

echo " Configure for hibernation"



limine-mkinitcpio
limine-install
echo "UUID"
findmnt -no UUID -T /swap/swapfile
echo "resume_offset"
btrfs inspect-internal map-swapfile -r /swap/swapfile
