# vars
conn_name="Connectoion-Name-Here"
iface="wlan0"
ssid="ssid-Name-Here"
method="auto"
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
    echo
done
# configure connection.
sudo nmcli con mod "$conn_name" \
    connection.interface-name "$iface" \
    802-11-wireless.ssid "$ssid" \
    802-11-wireless.mode infrastructure \
    802-11-wireless-security.key-mgmt wpa-psk \
    802-11-wireless-security.psk "$wifi_psk" \
    ipv4.method "$method" \
    ipv6.method "$disable"
# enable the connection.
sudo nmcli con up "$conn_name"
## script end ##
