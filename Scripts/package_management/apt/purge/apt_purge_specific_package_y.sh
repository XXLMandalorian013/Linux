#!/bin/bash
# vars
package_name="firefox"
## script start ##
# purges a specific package w/ out prompting. Will remove dependencies no longer needed.
sudo apt purge "$package_name" -y
## script end ##

