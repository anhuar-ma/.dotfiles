#!/bin/bash
#sudo pacman -S --needed base-devel
sudo pacman -S git --needed
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
cd
cd .dotfiles
stow .
cd
#Some packages are missing for emacs to work
paru -Syu imwheel ifplugd flameshot lxappearance htop xclip lightdm xorg-server lightdm-gtk-greeter google-chrome clipboard xorg-xinput mlocate arandr base-devel linux-lts-headers qtile python-psutil pywal-git feh picom dunst zsh starship playerctl awesome-git brightnessctl alacritty-git neofetch thunar thunar-archive-plugin ark rofi-git ranger cava neovim vim git lightdm keepassxc syncthing brave-bin jetbrains-toolbox ttf-jetbrains-mono-nerd fish kwrite obsidian code gvfs obs-studio v4l2loopback-dkms discord spotify-launcher libreoffice-still opentabletdriver xf86-input-libinput mpv qbittorrent exa zoom xfce4-screensaver xfce4-power-manager anki kdeconnect networkmanager firefox opera librewolf-bin jetbrains-toolbox stow dosfstools ntfs-3g xorg-xrandr emacs --needed
systemctl --user enable syncthing.service
systemctl --user start syncthing.service
#sysetmctl enable sddm
#Chainging shell
chsh -s $(which fish)
#Chainging root shell
su
chsh -s $(which fish)
#Create hibernation file of 24GB
sudo dd if=/dev/zero of=/swapfile bs=1M count=24k status=progress
sudo chmod 0600 /swapfile
sudo mkswap -U clear /swapfile
sudo swapon /swapfile
#Remember to add the fstab file the swap file
#Installing doom emacs
git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs
~/.config/emacs/bin/doom install
