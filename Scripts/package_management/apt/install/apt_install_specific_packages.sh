#!/bin/bash
# vars
package_name="firefox chromium vlc"
## script start ##
# installs a specific packages w/ out prompting.
sudo apt install "$package_name" -y
## script end ##

