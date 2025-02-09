#!/bin/bash
pkill -f obsidian &
(sleep .5 && obsidian) &
brave --profile-directory='Default' --new-window --password-store=basic --enable-chrome-browser-cloud-management https://www.udemy.com/course/complete-ethical-hacking-bootcamp-zero-to-mastery/learn &
virtualboxvm --startvm "Kali linux" &
