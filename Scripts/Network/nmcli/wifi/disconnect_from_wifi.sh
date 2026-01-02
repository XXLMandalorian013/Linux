#!/bin/bash
# vars
conn_name="Connection-Name-Here"
## script start ##
sudo nmcli connection down id "$conn_name"
## script end ##
