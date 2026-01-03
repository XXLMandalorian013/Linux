#!/bin/bash
# vars
package_name="firefox chromium vlc"
## script start ##
# updates a specific package w/ out prompting.
sudo apt upgrade "$package_name" -y
## script end ##

