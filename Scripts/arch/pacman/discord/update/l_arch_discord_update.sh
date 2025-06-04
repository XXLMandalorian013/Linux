#!/bin/bash
#<<< start readme
#region
# readme
#
# title: l_arch_pacman_discord_update.sh
#
# synopsis:
#   checks if arch is the os, checks if pacman is installed, updates pacman repos,
#   check current and new discord ver and insatlls a newer version if able.
#
# notes:
#   script must be ran as sudo when called as pacman package repo update and pacman pacak update require it.
#
# inputs:
#   None.
#
# outputs:
#   status messages printed to the console.
#
# example:
#   copy and past functions and call them manually or run locally like so below,
#   cd /script/location
#   chmod + x l_arch-pacman-discord-update.sh
#   sudo ./script/location/arch-pacman-discord-update.sh
#
# LINK:
#   https://example.com/documentation
#
#endregion
#>>> end readme
#<<< Start Script
#region
# script vars
# Path to log folder.
log_folder_path="/var/log/tmp-dir-99"
# Name of the log file.
log_file_name="script.log"
# Full path to the log file.
log_file_path="${log_folder_path}/${log_file_name}"

# function to create the logging folder.
create_logging_folder () {
  echo "creating logging folder..."
  if [ -d "$log_folder_path" ]; then
    echo "$log_folder_path already exists...continuing..."
  else
    echo "$log_folder_path does not exist...creating it..."
    sudo mkdir -p "$log_folder_path"
    if [ $? -eq 0 ]; then
      log_and_echo "folder $log_folder_path created successfully...continuing script..."
    else
      echo "error creating folder $log_folder_path...ending script..."
      exit
    fi
  fi
}
# function to create the log file.
create_log_file () {
  echo "creating log file..."
  if [ -f "$log_file_path" ]; then
    echo "log file '$log_file_path' already exists...continuing..."
  else
    echo "log file $log_file_path does not exist...creating it..."
    # Create the log file.
    # Using sudo because the folder is in /var/log which usually requires root privileges.
    sudo touch "$log_file_path" # Always quote file paths to handle spaces or special characters
    if [ $? -eq 0 ]; then # Check if the last command was successful
      echo "log file '$log_file_path' created successfully...continuing script..."
    else
      echo "error creating log file '$log_file_path'...ending script..."
      exit 1
    fi
  fi
}
# function to write a step into the log file.
write_log_step () {
  # Assign the first argument to a local variable for clarity.
  local log_message="$1"
  # Get the current timestamp in a consistent format.
  local timestamp=$(date +"%Y-%m-%d %H:%M:%S")

  # Construct the log entry and append it to the log file.
  # Using tee with sudo allows us to write to the file with root privileges.
  # The -a option appends to the file, and > /dev/null suppresses output to the console.
  echo "[$timestamp] $log_message" | sudo tee -a "$log_file_path" > /dev/null
  # Check if the write operation was successful.
  if [ $? -ne 0 ]; then
    echo "WARNING: Failed to write to log file: $log_file_path" >&2
  fi
}
# function to echo a message to the console and log it to the file.
log_and_echo () {
  local message="$1"
  echo "$message"
  write_log_step "$message"
}
# function for terminal sudo check.
os_check() {
  log_and_echo "os_check function start" # This one can remain separate as it's a function start marker
  #get the os name.
  local os_name=$(grep ^NAME= /etc/os-release | cut -d= -f2 | tr -d '"')
  #os check
  if [ "$os_name" == "Arch Linux" ]; then
    log_and_echo "arch linux system found...continuing script..."
  else
    log_and_echo "this system is $os_name...ending script..."
    exit
  fi
}
# function for terminal sudo check.
terminal_elevation_check () {
  log_and_echo "terminal_elevation_check function start" # Function start marker
  if [[ "$UID" -ne 0 ]]; then
    log_and_echo "this script requires sudo privileges...ending script..." >&2
    exit
  fi
  log_and_echo "script is running with sudo privileges...contuning script..."
}
# function update discord via pacman
update_discord() {
  #vars
  #packages vars
  local package_1="pacman"
  #pacman packages vars
  local pacman_1="discord"
  # gets pacman's package current version.
  local current_version=$(pacman -qi "$pacman_1" | grep "^Version" | awk '{print $3}' 2>/dev/null || echo "not installed") # Handle case where discord is not installed
  # gets pacman's package latest version.
  local latest_version=$(pacman -Si "$pacman_1" | grep "^Version" | awk '{print $3}' 2>/dev/null || echo "not found") # Handle case where discord is not in repos
  #check if specific pacman packages are installed, if so, it updates them.
  log_and_echo "update_discord function start"
  if command -v "$package_1" &> /dev/null; then
      log_and_echo "$package_1 package manager is installed...syncing with the $package_1 repo..."
      sudo pacman -Sy --noconfirm
      log_and_echo "$package_1 repo updated...continuing script..."
          #check if the software is installed via pacman
          if pacman -Qsq "^$pacman_1$" &> /dev/null; then
            log_and_echo "$pacman_1 is installed via pacman...checking versions..."
              #comparing versions and attempting to install the latest.
              if [[ "$latest_version" == "$current_version" ]]; then
                  log_and_echo "$pacman_1 is already up to date ($current_version)...continuing script..."
              elif [[ "$latest_version" > "$current_version" ]]; then
                  log_and_echo "a newer version of $pacman_1 is available...updating to the latest version ($latest_version)..."
                  sudo pacman -S "$pacman_1" --noconfirm
                  log_and_echo "$pacman_1 has updated...continuing script..."
              else
                  log_and_echo "could not reliably compare versions for $pacman_1...skipping this section..."
              fi
          else
          log_and_echo "$pacman_1 is not installed via $package_1...continuing script..."
          fi
  else
    log_and_echo "$package_1 package manager is not installed...ending script..."
    exit
  fi
  #end of script.
  log_and_echo "the discord function has finished running...ending script..."
  exit
}
#calling functions
# function to create the logging folder.
create_logging_folder
# function to create the log file.
create_log_file
#checks if required os is present.
os_check
# function for terminal sudo check.
terminal_elevation_check
# function update discord via pacman.
update_discord
#endregion
#>>> End Script



