#!/bin/bash
# notes
# this script will install docker on a 64-bit system if not already installed.
# if you uninstalled docker without rebooting and tried to reinstall, reboot and try this script again.
## script start
# vars
# software name.
software_name="docker"
# url of the installer.
url="https://get.docker.com"
# checking if docker is installed, else installs it.
if command -v "$software_name" >/dev/null 2>&1; then
    echo "$software_name is already installed...ending script..."
else
    echo "$software_name is not installed...installing $software_name..."
    # downloading the installer script.
    if curl -s -o /dev/null -w "%{http_code}" "$url" | grep -q '^200$'; then
        echo "URL is reachable and returned 200 OK..downloading installer..."
        curl -fsSL $url -o get-docker.sh
        # running the downloaded installer script.
        echo "running $software_name installer..."
        sudo sh get-docker.sh
        # checks if the docker service is running after installation.
        if systemctl is-active --quiet $software_name; then
            echo "the docker service is running...docker installed correctly...ending script..."
        else
            echo "the docker service is not running..."
        fi
    else
    echo "URL is not reachable or returned non-200"
    fi
fi
## script end

