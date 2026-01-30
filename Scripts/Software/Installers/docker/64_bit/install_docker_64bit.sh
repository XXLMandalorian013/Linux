#!/bin/bash
# notes
## script start
# vars
# folder location.
# software service name
servicename="sophos-spl\.service"
folder="var"
# tmp folder name
tmpfolder="tmp-99"
# URL of the installer
url="https://dzr-api-amzn-us-west-2-fa88.api-upe.p.hmr.sophos.com/api/download/12345678901234567890/SophosSetup.sh"
# function to create a tmp folder, if it doesn't exist.
# output file name
outfile="SophosSetup.sh"
# checks to see if sophos is already installed, if so, ends the script.
pre-installcheck() {
    if systemctl list-units --type=service --all | grep -q "^$servicename"; then
    echo "sophos-spl.service found...exiting script..."
    exit 0
    else
    echo "s$servicename not found...continuing script..."
fi
}
create_folder() {
    local tmpfolder="$1"
    if [ -d "$tmpfolder" ]; then
        echo "Folder '$tmpfolder' already exists."
    else
        echo "Folder '$tmpfolder' not found. Creating it now..."
        sudo mkdir "$tmpfolder"
    fi
}
# function to download the Sophos installer.
download_installer() {
    # download using curl
    curl -L -o "$folder/$tmpfolder/$outfile" "$url"
    echo "downloaded $outfile to $folder/$tmpfolder."
}
# setting folder location for the DL and making the script executable.
make_executable() {
    cd "/$folder/$tmpfolder"
    chmod +x "$outfile"
}
run_installer() {
    ./"$outfile" --products=antivirus,mdr,xdr
}
## functions.
# checks to see if sophos is already installed, if so, ends the script.
pre-installcheck
# function to create a tmp folder, if it doesn't exist. Specified the var for the required folder.
create_folder "/$folder/$tmpfolder"
# function to download the Sophos installer.
download_installer
# setting folder location for the DL and making the script executable.
make_executable
# running the installer with required products.
run_installer
## script end


