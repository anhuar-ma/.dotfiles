#!/bin/bash
echo "Clonning the repo"
git clone git@github.com:anhuar-ma/.dotfiles.git

echo "Installing paru"
sudo pacman -S git base-devel --needed
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si

echo "Installing the dotfiles"
cd ~/.dotfiles
stow .
cd

#Some packages are missing for emacs to work
paru -Syu github-cli texlive man-db nwg-displays htop rofi-git ranger neovim git keepassxc syncthing zen-browser-bin ttf-jetbrains-mono-nerd fish obsidian visual-studio-code-bin opentabletdriver qbittorrent exa anki kdeconnect firefox librewolf-bin stow emacs netdiscover ttf-ms-win11-auto filezilla bat git-delta xournalpp fzf --needed
systemctl --user enable syncthing.service
systemctl --user start syncthing.service
echo "Chainging shell"
chsh -s $(which fish)
echo "Chainging root shell"
su
chsh -s $(which fish)
echo "Installing doom emacs"
git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs
~/.config/emacs/bin/doom install

echo "making debuggin.h available system wide"
sudo cp ~/.dotfiles/debugging.h /usr/local/include/

# Previous package needed for the wifi card to work v4l2loopback-dkms
