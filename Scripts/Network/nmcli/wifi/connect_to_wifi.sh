# wifi
# vars
conn_name="wifi-connection-name-here"
iface="wlan0"
ssid="ssid-name-here"
method="manual"
ipv4="XXX.XXX.XXX.XXX/24"
gateway="XXX.XXX.XXX.X"
dns="XXX.XXX.XXX.XXX"
disable="disabled"
## script start ##
# checks if the connection exists, if not, it creates it.
if nmcli con show "$conn_name" >/dev/null 2>&1; then
    echo "$conn_name exists, continuing..."
else
    echo "$conn_name does not exist, creating connection..."
    sudo nmcli con add type wifi \
    ifname "$iface" \
    con-name "$conn_name" \
    ssid "$ssid"
fi
# prompt for password and ensures the wifi password is not empty.
while [[ -z "$wifi_psk" ]]; do
    read -s -p "please enter wi-fi password: " wifi_psk
    # added for a space between the prompt above and the cmds below.
    echo
done
# configure connection.
sudo nmcli con mod "$conn_name" \
    connection.interface-name "$iface" \
    802-11-wireless.ssid "$ssid" \
    802-11-wireless.mode infrastructure \
    802-11-wireless-security.key-mgmt wpa-psk \
    802-11-wireless-security.psk "$wifi_psk" \
    ipv4.method manual \
    ipv4.addresses "$ipv4" \
    ipv4.gateway "$gateway" \
    ipv4.dns "$dns" \
    ipv4.ignore-auto-dns yes \
    ipv6.method disabled
# enable the connection.
sudo nmcli con up "$conn_name"
## script end ##
