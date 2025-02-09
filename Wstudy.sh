#!/bin/bash
pkill -f obsidian 
firefox  https://www.udemy.com/course/the-complete-web-development-bootcamp/learn &
obsidian &
nemo ~/Codes/WEB_DEVELOPMENT_PROJECTS/ -t ~/Downloads/ &
webstorm ~/Codes/WEB_DEVELOPMENT_PROJECTS/ &
