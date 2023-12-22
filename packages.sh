#!/bin/bash
sudo pacman -S --needed base-devel
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
cd
paru -Syu base-devel linux-lts-headers qtile python-psutil pywal-git feh picom dunst zsh starship playerctl brightnessctl alacritty-git neofetch thunar rofi ranger cava pulseaudio alsa-utils neovim vim git sddm keepassxc syncthing brave-bin ttf-ms-win11-auto jetbrains-toolbox ttf-jetbrains-mono-nerd fish kwrite obsidian code gvfs obs-studio v4l2loopback-dkms discord spotify-launcher libreoffice-still opentabletdriver xf86-input-libinput mpv qbittorrent exa zoom xfce4-screensaver xfce4-session xfce4-power-manager anki kdeconnect networkmanager xfce4 firefox opera librewolf jetbrains-toolbox stow dosfstools ntfs-3g --needed
systemctl --user enable syncthing.service
systemctl --user start syncthing.service
chsh -s $(which fish)
#Create hibernation file of 20GB
sudo dd if=/dev/zero of=/swapfile bs=1M count=20k status=progress
sudo chmod 0600 /swapfile
sudo mkswap -U clear /swapfile
sudo swapon /swapfile
cd
cd .dotfiles
stow .
