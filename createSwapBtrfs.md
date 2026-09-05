- Docs: https://wiki.archlinux.org/title/Btrfs#Swap_file

<!-- swapon -p 0 /swap/swapfile -->
# Create the swapfile

```
btrfs subvolume create /swap
btrfs filesystem mkswapfile --size 20g --uuid clear /swap/swapfile
swapon /swap/swapfile
echo "Add to /etc/fstab"
echo "/swap/swapfile none swap defaults 0 0"

```

# Configure hibernation
- Docs: https://wiki.archlinux.org/title/Power_management/Suspend_and_hibernate

1) Add `resume` to hooks in `/etc/mkinitcpio.conf` 

2) Add the kernel parameter `resume=*swap_device*`
    echo "UUID"
    findmnt -no UUID -T /swap/swapfile
  if it does not work with UUID do 

  ```
resume=/dev/mapper/root

```

3) Add the kernel parameter `resume_offset=` in `/etc/default/limine`
echo "resume_offset"
btrfs inspect-internal map-swapfile -r /swap/swapfile

4) rebuild:
```
   limine-mkinitcpio
   limine-install
```

# Example file:

```


KERNEL_CMDLINE[default]="cryptdevice=PARTUUID=111111111111111111111111111111111111:root root=/dev/mapper/root zswap.enabled=0 rootflags=subvol=@ rw rootfstype=btrfs resume=UUID=222222222222222222222222222222222222 resume_offset=33333333"
KERNEL_CMDLINE[default]+="quiet splash"



```

5) Eliminate swapfile

```
sudo swapoff /swap/swapfile
sudo rm /swap/swapfile
sudo btrfs subvolume delete /swap
```
