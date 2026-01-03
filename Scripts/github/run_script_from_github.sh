#!/bin/bash
# vars
# github url
url="https://raw.githubusercontent.com/you/repo/main/script.sh"
# just the script name from the url.
script_name="$(basename "$url")"
## script start ##
echo "running script_name...please wait..."
# run the script without saving it to disk.
curl -fsSL "$url" | bash
## script end ##
