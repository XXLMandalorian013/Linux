#!/bin/bash
# vars
conn_name="ethernet-static"
iface="eth0"
method="manual"
ipv4="XXX.XXX.XXX.XXX/24"
gateway="XXX.XXX.XXX.X"
dns="XXX.XXX.XXX.XXX"
disable="disabled"
## script start ##
# check if the connection exists, if not, create it
if nmcli con show "$conn_name" >/dev/null 2>&1; then
    echo "$conn_name exists, continuing..."
else
    echo "$conn_name does not exist, creating connection..."
    sudo nmcli con add type ethernet \
        ifname "$iface" \
        con-name "$conn_name"
fi
# configure connection
sudo nmcli con mod "$conn_name" \
    connection.interface-name "$iface" \
    ipv4.method manual \
    ipv4.addresses "$ipv4" \
    ipv4.gateway "$gateway" \
    ipv4.dns "$dns" \
    ipv4.ignore-auto-dns yes \
    ipv6.method "$disable"
# enable the connection
sudo nmcli con up "$conn_name"
## script end ##
