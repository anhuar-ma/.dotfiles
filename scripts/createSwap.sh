#!/bin/bash
cd &&
echo "Creating a Swap file of 24GB"
sudo dd if=/dev/zero of=/swapfile bs=1M count=24k status=progress && sudo chmod 0600 /swapfile && sudo mkswap -U clear /swapfile && sudo swapon /swapfile &&
echo "-----------------------------------------------------------------------------------"
echo "WHAT NEXT?"
echo "Add this to the /etc/fstab"
echo "/swapfile none swap defaults 0 0"
echo "Add the 'resume' hook to /etc/mkinitcpio.conf"
echo "Add to /etc/default/grub resume=UUID=swap_device_uuid resume_offset=swap_file_offset"
echo "swap_device_uuid:"
findmnt -no UUID -T /swapfile
echo "swap_file_offset:"
filefrag -v /swapfile | awk '$1=="0:" {print substr($4, 1, length($4)-2)}'
echo "saving changes in grub"
echo "mkinitcpio -P && grub-mkconfig -o /boot/grub/grub.cfg"
