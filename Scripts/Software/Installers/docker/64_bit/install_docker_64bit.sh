#!/bin/bash
# notes
## script start
# vars
# folder location.
# software name.
software_name="docker"
# url of the installer.
url="https://get.docker.com"
# checking for docker service status
if systemctl is-active --quiet "$software_name"; then
    echo "$software_name is already installed...ending script..."
else
    echo "$software_name is not installed...installing $software_name..."
    # updating package index
    echo "updating package index...please wait..."
    sudo apt-get update
    # downloading the installer script.
    if curl -s -o /dev/null -w "%{http_code}" "$url" | grep -q '^200$'; then
        echo "URL is reachable and returned 200 OK..downloading installer..."
        curl -fsSL $url -o get-docker.sh
        # running the downloaded installer script.
        echo "running $software_name installer..."
        sudo sh get-docker.sh
        if systemctl is-active --quiet $software_name; then
            echo "the docker service is running...ending script..."
        else
            echo "the docker service is not running"
        fi
    else
    echo "URL is not reachable or returned non-200"
    fi
fi
## script end

