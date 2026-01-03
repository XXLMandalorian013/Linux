#!/bin/bash
# vars
pack_name="firefox chromium vlc"
## script start ##
# updates a specific package w/ out prompting.
sudo apt upgrade "$pack_name" -y
## script end ##

