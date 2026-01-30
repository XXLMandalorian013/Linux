#!/bin/bash
# notes
# this script will not remove images, containers, volumes.
# you should reboot the system after uninstalling docker to avoid issues when reinstalling.
## script start
# software name.
software_name="docker"
# checking if docker is installed, else installs it.
if command -v "$software_name" >/dev/null 2>&1; then
    # stopping the services.
    echo "$software_name is installed...continuing script..."
    # stopping docker socket service first as if you stop docker service first, docker wines that the socket remains active.
    echo "stopping the docker socket..."
    sudo systemctl stop docker.socket
    echo "stopping the docker service..."
    sudo systemctl stop docker
    # tries to uninstall docker packages.
    echo "uninstalling $software_name...please wait..."
    # packages list to be checked.
    packages=(
        docker-ce
        docker-ce-cli
        containerd.io
        docker-buildx-plugin
        docker-compose-plugin
    )
    for pkg in "${packages[@]}"; do
        if dpkg -s "$pkg" >/dev/null 2>&1; then
            echo "Purging $pkg..."
            sudo apt-get purge -y "$pkg"
        else
            echo "$pkg not installed, skipping"
        fi
    done
    # removing leftover files.
    if [ -d "/var/lib/docker" ]; then
        echo "removing /var/lib/docker..."
        sudo rm -rf /var/lib/docker
    fi
    if [ -d "/var/lib/containerd" ]; then
        echo "removing /var/lib/containerd..."
        sudo rm -rf /var/lib/containerd
    fi
    echo "$software_name uninstallation completed...ending script..."
    echo "reboot the system to avoid issues when reinstalling...""
else
    echo "$software_name is not installed...ending script..."
fi
## script end

