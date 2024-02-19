#!/bin/bash
pkill -f obsidian 
brave --profile-directory='Profile 1' --new-window --password-store=basic --enable-chrome-browser-cloud-management https://www.udemy.com/course/the-complete-web-development-bootcamp/learn/lecture/37350652#overview &
obsidian &
nemo ~/Codes/WEB_DEVELOPMENT_PROJECTS/ -t ~/Downloads/ &
